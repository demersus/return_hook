module ReturnHook
  module FormTagHelper
    private
    # This method overrides the rails built in form helper's action setting code
    # to inject a return path
    def html_options_for_form(url_for_options, options)
      options.stringify_keys.tap do |html_options|
        html_options["enctype"] = "multipart/form-data" if html_options.delete("multipart")
        # The following URL is unescaped, this is just a hash of options, and it is the
        # responsibility of the caller to escape all the values.

        ## OVERRIDDEN HERE:
        html_options["action"] = forward_return_hook(url_for(url_for_options))

        html_options["accept-charset"] = "UTF-8"

        html_options["data-remote"] = true if html_options.delete("remote")

        if html_options["data-remote"] &&
           !embed_authenticity_token_in_remote_forms &&
           html_options["authenticity_token"].blank?
          # The authenticity token is taken from the meta tag in this case
          html_options["authenticity_token"] = false
        elsif html_options["authenticity_token"] == true
          # Include the default authenticity_token, which is only generated when its set to nil,
          # but we needed the true value to override the default of no authenticity_token on data-remote.
          html_options["authenticity_token"] = nil
        end
      end
    end
  end
end