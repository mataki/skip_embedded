# Include hook code here
require 'skip_collabo/initial_settings'
Thread.critical{
  SkipCollabo::InitialSettings.config = File.expand_path("config/initial_settings.yml", Rails.root)
  SkipCollabo.instance # force loading
}
