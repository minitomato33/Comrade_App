// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
// import * as ActiveStorage from "@rails/activestorage"
// import "channels"

// Rails.start()
// Turbolinks.start()
// ActiveStorage.start()
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
// * turbolinksによる画面遷移時、rails-ujsが2回読み込まれ、
//    data-animate-effect="fadeInLeft"が発火しない問題が発生するため、turbolinks機能を無効化 */
// require("turbolinks").start()