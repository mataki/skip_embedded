require 'net/http'
require "net/https"
require 'uri'
require 'erb'

module SkipCollabo
  class WebServiceUtil
    module Client
      # 別のWebアプリのWeb-APIをコールするためのユーティリティメソッド
      # Webアプリ連携の際は、このメソッドを経由して利用すること
      # 引数
      #    :app_name = 呼び出したいWebアプリケーションのシンボル
      #    :service_name = 呼び出したいWeb-APIの名前
      #    :params = 呼び出す際のパラメータ
      #    :controller_name = サービスのコントローラパス（デフォルトの規約は"services"）
      #      services以外を指定も可能だが、それは茨の道と思へ
      def open_service app_name, service_name, params={}, controller_name="services"
        app_url, app_ca_file = if app = INITIAL_SETTINGS['collaboration_apps'][app_name.to_s]
                                 [ app["url"], app["ca_file"] ]
                               else
                                 [nil, nil]
                               end
        url = "#{app_url}/#{controller_name}/#{service_name}"
        self.open_service_with_url(url, params, app_ca_file)
      end

      def open_service_with_url url, params = {}, app_ca_file = nil
        url = "#{url}?" +
          params.map{|key, val| "#{ERB::Util.u(key.to_s)}=#{ERB::Util.u(val.to_s)}"}.join('&')
        self.get_json(url, app_ca_file)
      end

      def get_json(url, ca_file = nil)
        uri = URI.parse url
        http = Net::HTTP.new(uri.host, uri.port)
        if uri.port == 443
          http.use_ssl = true
          if ca_file
            http.verify_mode = OpenSSL::SSL::VERIFY_PEER
            http.ca_file = ca_file
            http.verify_depth = 5
          else
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          end
        end
        response = http.get("#{uri.path}?#{uri.query}", "X-SECRET-KEY" => INITIAL_SETTINGS['secret_key'])
        if response.code == "200"
          JSON.parse(response.body)
        else
          ActiveRecord::Base.logger.error "[WebServiceUtil Error] Response code is #{response.code} to access #{url}"
          nil
        end
      rescue Errno::ECONNREFUSED, OpenSSL::SSL::SSLError, SocketError, ArgumentError, JSON::ParserError, URI::InvalidURIError => ex
        ActiveRecord::Base.logger.error "[WebServiceUtil Error] #{ex.to_s} to access #{url}"
        nil
      end
    end
  end
end
