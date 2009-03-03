require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'skip_collabo/initial_settings'

describe SkipCollabo::InitialSettings do
  # see spec/initial_setting.yml
  it{
    SkipCollabo::InitialSettings[:skip_collabolation]["skip_url"].should ==  "http://test.openskip.org"
  }
end

