// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

//Bootstrapの導入
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
//Fontawesomeの導入
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

//jQueryの呼び出し
window.$ = window.jQuery = require('jquery');


//Raty.js
import Raty from "src/raty.js"
window.raty = function(elem,opt) {
  let raty =  new Raty(elem,opt)
  raty.init();
  return raty;
}

//= require jquery
//= require rails-ujs