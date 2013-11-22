module Rich
  class CmsSessionsController < ::ApplicationController
    before_filter :allow_params_authentication!, :only => :login

    def login
      @success = Rich::Cms::Auth.login

      if request.xhr?
        respond_to do |format|
          format.js
        end
      else
        redirect_to "/"
      end
    end

    def logout
      Rich::Cms::Auth.logout
      if request.xhr?
        respond_to do |format|
          format.js
        end
      else
        redirect_to "/"
      end
    end

  private

    # Tell warden that params authentication is allowed for that specific page.
    def allow_params_authentication!
      request.env["devise.allow_params_authentication"] = true
    end

  end
end