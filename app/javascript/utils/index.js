import $ from 'jquery'
import Cleave from 'cleave.js'
import autocomplete from 'jquery-ui/ui/widgets/autocomplete'

const cleaveCurrencyOption = {
  prefix: '$',
  delimiterLazyShow: true,
  noImmediatePrefix: true,
  numeral: true,
  numeralDecimalScale: 0,
  numeralThousandsGroupStyle: 'thousand'
}

const setCurrencyMask = function(selector) {
  new Cleave(selector, cleaveCurrencyOption)
}

const setCompanyNameAutocomplete = function(selector) {
  const $input = $(selector)
  if (!$input || $input.length == 0)
    return

  $input.autocomplete({
    minChars: 2,
    source: function(req, res){
      $.getJSON('https://autocomplete.clearbit.com/v1/companies/suggest', { query: req.term }, function(data){ res(data); });
    },
    focus: function(event, ui){
      $input.val(ui.item.name);
      return false;
    },
    select: function(event, ui){
      $input.val(ui.item.name);
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

export {
  setCompanyNameAutocomplete,
  setCurrencyMask,
}
