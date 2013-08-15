require 'return_hook/version'
require 'return_hook/controller'
require 'return_hook/form_tag_helper'
require 'return_hook/responder'

module ReturnHook

end

ActionController::Base.send :include, ReturnHook::Controller
ActionController::Base.helper ReturnHook::FormTagHelper