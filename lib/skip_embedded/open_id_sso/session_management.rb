
module SkipEmbedded
  module OpenIdSso
    module SessionManagement
      def self.included(controller)
        controller.before_filter :available_op_limitation, :only => %w[create]
      end

      private
      def after_logout_path
        OpFixation.sso_openid_logout_url || login_path
      end

      def login_successfully(user, personal_data)
        if OpFixation.sso_enabled?
          data = attribute_adapter.adapt(personal_data)
          user.update_attributes!(data.slice(:display_name))
          flash[:notice] = _("Successfully synchronized your display name with OP's")
        end
        super
      end

      def signup(identity_url, personal_data = {})
        session[:user] = attribute_adapter.adapt(personal_data) if OpFixation.sso_enabled?
        super
      end

      def available_op_limitation
        if params[:openid_url] && !OpFixation.accept?(params[:openid_url])
          logger.debug("login refused since #{params[:openid_url]} is not member #{OpFixation.servers.inspect}")
          authenticate_failure
        elsif OpFixation.sso_enabled? && !params["open_id_complete"].blank? && (params["openid.identity"] != params["openid.claimed_id"])
          logger.debug("login refused since claimed_id differs from identity.")
          authenticate_failure
        else
          true
        end
      end
    end
  end
end

