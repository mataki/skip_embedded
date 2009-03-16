module SkipEmbedded
  # FIXME moduleにする
  class WebServiceUtil
    module Server
      def check_secret_key
        req_key = request.env["HTTP_X_SECRET_KEY"] && request.env["HTTP_X_SECRET_KEY"]
        unless  req_key == InitialSettings['skip_collaboration']['secret_key']
          render :text => { :error => "Forbidden" }.to_json, :status => :forbidden
          return false
        end
      end
    end
  end
end
