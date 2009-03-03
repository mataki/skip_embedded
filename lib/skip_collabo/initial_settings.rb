require 'singleton'

module SkipCollabo
  class InitialSettings
    include Singleton
    def self.config=(abs_path)
      @config_path = abs_path
    end

    def self.config
      @config_path ||= File.expand_path("config/initial_settings.yml", Rails.root)
    end

    def self.[](key)
      instance[key]
    end

    def initialize
      env = defined?(RAILS_ENV) ? RAILS_ENV : "development"
      @config = YAML.load_file(self.class.config)[env].freeze
    end

    def [](key)
      @config[key.to_s]
    end
  end
end

