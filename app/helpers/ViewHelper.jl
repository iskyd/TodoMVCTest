module ViewHelper

using Genie, Genie.Flash, Genie.Router

export output_flash

function output_flash(flashtype::String = "danger") :: String
  flash_has_message() ? """<div class="alert alert-$flashtype alert-dismissable">$(flash())</div>""" : ""
end

function active(filter::String = "")
  params(:filter, "") == filter ? "active" : ""
end

end