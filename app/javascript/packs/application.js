/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import NewOffer from 'offers/new'
import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'
import 'jquery/src/jquery'
import 'bootstrap/dist/js/bootstrap'

const ondomloaded = () => {
  NewOffer.setMasking()
  NewOffer.setAutocomplete()
  if (__sharethis__ && __sharethis__.config) {
    __sharethis__.href = document.location.href
    __sharethis__.init(__sharethis__.config);
  }
}

document.addEventListener("DOMContentLoaded", ondomloaded)
document.addEventListener("turbolinks:load", ondomloaded)

Turbolinks.start()
Rails.start()
