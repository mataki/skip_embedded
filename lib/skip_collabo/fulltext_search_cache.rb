require "config/environment"
require "fileutils"
require "skip_collabo/fulltext_search_cache/mediator"

module SkipCollabo
  module FulltextSearchCache
    DEFAULT_OPTIONS = {
      :cache_dir => File.expand_path("fts_cache/app_cache", Rails.root),
      #:entity_dirs => %w[note page attachment],
      :logger    => Rails.logger,
      :limit => 1_000,
    }.freeze

    def self.build(model_and_builders, options = {})
      if skip_url = (INITIAL_SETTINGS[:skip_collabolation] && INITIAL_SETTINGS[:skip_collabolation][:skip_url])
        set_default_url_options(skip_url)
      else
        $stderr.puts "set skip_collabolation -> skip_url in config/initial_settings.yml"
        exit 1
      end

      mediator = Mediator.new(options)
      model_and_builders.each{|m, b| mediator.build(m, b) }

      mediator.finish
    end

    def self.set_default_url_options(url)
      u = URI(url)
      url_opt = { :host => u.host, :protocol => u.scheme }
      url_opt[:port] = u.port unless (u.scheme == "http" && u.port == 80) || (u.scheme == "https" && u.port == 443)
      ActionController::UrlWriter.default_url_options = url_opt
    end
  end
end

