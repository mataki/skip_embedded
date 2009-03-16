require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'skip_collabo/initial_settings'

describe SkipEmbedded::InitialSettings do
  # see spec/initial_setting.yml
  it{
    SkipEmbedded::InitialSettings[:skip_collaboration]["skip_url"].should ==  "http://test.openskip.org"
  }
end

