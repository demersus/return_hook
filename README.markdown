ReturnHook
==========

ReturnHook gives you some conveniences for hooking returns from controller redirects. It works by interacting with a url parameter 'return'  (params[:return]). By specifying this parameter, you are able to override the redirect in a controller action to return the user to the url of your choice.

Convenience Methods
-------------------

### smart_redirect
This method is a replacement for redirect_to in your controllers.  It takes the same parameters, but is aware of any pending return hooks.  If it detects `params[:return]`, then it will redirect to the url specified under `params[:return]`, instead of the one given to it in it's first parameter.

##### Example:
You have accessed a controller action with ?return=/your-url.  At the end of your action you write:  `smart_redirect(users_path)`.  Because ?return=/your-url is present in your calling url, it will redirect to /your-url instead of users_path.  Otherwise it will follow the same semantics of redirect_to

### url_for_return
This method is available to both controllers and views.  It takes a url_for argument, and adds a return parameter equal to the present url.

##### Example:
You want to have the user go to a certain action, but once they have completed that flow, they will be redirect back to this page.

### forward_return_hook
This method is also available to both controllers and views.  You feed it a url, and if `params[:return]` is present, then it will automatically add the return parameter to the url specified.  It returns the url + the return hook.

#### Form Helpers:
The form helper is automatically overridden to forward the return hook to it's action parameter.  This works with all form builders.  (simple_form, formatastic, etc...).  So if you use the return hook in the url, and that page has a form in it, then that form will submit to it's action, and include the return hook in that url.  The controller action responsible for handling that action can then handle the form submission, and use `smart_redirect` to redirect to the return hook if specified.

Responders, respond_with
------------------------
If you would like to have respond_with at the end of your controller methods, and use ReturnHook, then you can `include ReturnHook::Responder` in your own responder class.  This will override the redirect_to inside your responder to use `smart_redirect` for catching any return hooks.

##### Example:

###### lib/app_responder.rb
```ruby
  class AppResponder < ActionController::Responder
    include ReturnHook::Responder
  end
```
###### app/controllers/application_controller.rb
```ruby
  require 'app_responder'
  class ApplicationController < ActionController::Base
    self.responder = AppResponder
    ...
```