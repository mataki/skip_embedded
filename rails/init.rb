# Include hook code here
require 'skip_embedded/initial_settings'
Thread.critical{
  SkipEmbedded::InitialSettings.config = File.expand_path("config/initial_settings.yml", Rails.root)
  SkipEmbedded.instance # force loading
}

config.gem 'gettext', :lib => 'gettext/rails', :version => '1.93.0'
config.gem 'moro-repim', :lib => 'repim', :version => '>=0.1.4', :soruce => 'http://gems.github.com/'

