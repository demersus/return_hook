module ReturnHook
  module Responder
    def redirect_to(options = {}, response_status = {})
      if format == :html && !request.xhr?
        # follow returns by using the smart method
        controller.smart_redirect(options,response_status)
      else
        controller.redirect_to options,response_status
      end
    end
  end
end