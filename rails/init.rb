# Include hook code here
require 'skip_collabo/initial_settings'
Thread.critical{
  SkipEmbedded::InitialSettings.config = File.expand_path("config/initial_settings.yml", Rails.root)
  SkipEmbedded.instance # force loading
}
