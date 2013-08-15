module ReturnHook
  module Controller
    def self.included(base)
      base.send :helper_method, :url_for_return, :forward_return_hook
    end
    def smart_redirect(options = {}, response_status = {})
      if !((response_status.include?(:override_return) ||
          (options.is_a?(Hash) && options.include?(:override_return))))
        uri = params[:return]
        if uri
          redirect_to CGI.unescape(uri), response_status
        elsif (options == :back)  && request.env['HTTP_REFERER'].blank?
          redirect_to '/'
        else
          redirect_to options, response_status
        end
      elsif (options == :back)  && request.env['HTTP_REFERER'].blank?
        redirect_to '/'
      else
        redirect_to options, response_status
      end
    end
    def url_for_return(params)
      escaped_url = CGI.escape request.url
      if params.is_a? String
        params = params.include?('?') ? params + '&return=' + escaped_url : params + '?return=' + CGI.escape(escaped_url)
      elsif params.is_a? Hash
        params[:return] = escaped_url
      end
      url_for params
    end
    def forward_return_hook(url)
      if params[:return]
        if url.is_a? String
          url = url.include?('?') ? url + '&return=' + params[:return] : url + '?return=' + params[:return]
        elsif url.is_a? Hash
         url[:return] = params[:return]
        end
      end
      url_for url
    end
  end
end