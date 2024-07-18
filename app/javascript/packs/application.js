import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import "bootstrap/dist/js/bootstrap.bundle";
import "bootstrap/dist/css/bootstrap";
import 'bootstrap-icons/font/bootstrap-icons.css';  
import "@fortawesome/fontawesome-free/js/all";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="dropdown"]').dropdown();
});