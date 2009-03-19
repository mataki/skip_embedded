module SkipEmbedded
  module OpenIdSso
    module Authentication
      def self.included(base)
        base.alias_method_chain :access_denied, :open_id_sso
      end

      private
      def access_denied_with_open_id_sso(message = nil)
        if op = SkipEmbedded::OpFixation.sso_openid_provider_url
          store_location
          options = {:method => "post", :return_to => session_url}
          if attr_adapter = SessionsController.attribute_adapter
            options[attr_adapter.necessity] = attr_adapter.keys
          end
          authenticate_with_open_id(op, options) do
            access_denied_without_open_id_sso(message)
          end
        else
          access_denied_without_open_id_sso(message)
        end
      end
    end
  end
end
