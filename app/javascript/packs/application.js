require("@rails/ujs").start()
require("turbolinks").start()

import 'jquery'
import 'src/plugins'
import 'css/offerkarma'

const ondomloaded = () => {
  if (window.__sharethis__ && __sharethis__.config) {
    __sharethis__.href = document.location.href
    __sharethis__.init(__sharethis__.config);
  }
}

document.addEventListener("DOMContentLoaded", ondomloaded)
document.addEventListener("turbolinks:load", ondomloaded)

import {
  setCompanyNameAutocomplete,
  setCurrencyMask
} from 'utils/index'

window.OfferKarma = {
  setCompanyNameAutocomplete,
  setCurrencyMask
}
