import Cleave from 'cleave.js'
import $ from 'jquery'
import autocomplete from 'jquery-ui/ui/widgets/autocomplete'

export default {
  setMasking: () => {
    const cleaveCurrencyOption = {
      prefix: '$',
      delimiterLazyShow: true,
      noImmediatePrefix: true,
      numeral: true,
      numeralDecimalScale: 0,
      numeralThousandsGroupStyle: 'thousand'
    }

    if (document.getElementById('offer_base_salary')) {
      new Cleave('#offer_base_salary', cleaveCurrencyOption);
      new Cleave('#offer_relocation_package', cleaveCurrencyOption);
      new Cleave('#offer_signon_bonus', cleaveCurrencyOption);
    }

    if (document.getElementById('offer_stock_grant_value')) {
      new Cleave('#offer_stock_grant_value', cleaveCurrencyOption);
    }
  },

  setAutocomplete: () => {
    const $companyNameInput = $('#offer_company_name')

    if ($companyNameInput.length == 0)
      return

    $companyNameInput.autocomplete({
      minChars: 2,
      source: function(req, res){
        $.getJSON('https://autocomplete.clearbit.com/v1/companies/suggest', { query: req.term }, function(data){ res(data); });
      },
      focus: function(event, ui){
        $companyNameInput.val(ui.item.name);
        return false;
      },
      select: function(event, ui){
        $companyNameInput.val(ui.item.name);
        return false;
      },
      messages: {
        noResults: '',
        results: function() {}
      }
    }).autocomplete('instance')._renderItem = function(ul, item) {
      ul.addClass('list-group')

      return $('<li class="d-flex list-group-item list-group-item-action">')
        .append('<div class="mr-auto"><img src="' + item.logo + '?size=20" class="mr-2" />'+item.name+'</div><div class="ml-auto small text-muted">' + item.domain + '</div>')
        .appendTo(ul);
    };
  }
}
