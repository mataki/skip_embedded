require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'skip_collabo/op_fixation'

describe SkipEmbedded::OpFixation, "http://openid.example.comで擬似SSOをする場合", :type => :model do
  before() do
    SkipEmbedded::OpFixation.sso_openid_provider_url = "http://openid.example.com/"
  end

  it "sso_openid_provider_urlは@server_endpoint_urlであること" do
    SkipEmbedded::OpFixation.sso_openid_provider_url.should == "http://openid.example.com/"
  end

  it "sso_openid_logout_urlは@server_endpoint_url + '/logout'であること" do
    SkipEmbedded::OpFixation.sso_openid_logout_url.should == "http://openid.example.com/logout"
  end
end

describe SkipEmbedded::OpFixation, "[http://openid.example.com]を受け付ける場合", :type => :model do
  before(:all) do
    @server_endpoint_url = "http://openid.example.com/server"
    SkipEmbedded::OpFixation.servers = @server_endpoint_url
  end

  describe "OpenID.discoverのOP endpoint URLがhttp://openid.example.comの場合" do
    before do
      mock_op_service = mock("op_service")
      mock_op_service.should_receive(:server_url).and_return @server_endpoint_url
      OpenID.should_receive(:discover).and_return [:ignore, [mock_op_service]]
    end

    it "http://openid.example.com/alice/での問い合わせは許可すること" do
      SkipEmbedded::OpFixation.accept?("http://openid.example.com/alice/").should be_true
    end
  end

  describe "OpenID.discoverのOP endpoint URLがhttp://not-registered.example.comの場合" do
    before do
      mock_op_service = mock("op_service")
      mock_op_service.should_receive(:server_url).and_return "http://not-registered.example.com"
      OpenID.should_receive(:discover).and_return [:ignore, [mock_op_service]]
    end

    it "http://not-registered.example.com/alice/での問い合わせは許可しないこと" do
      SkipEmbedded::OpFixation.accept?("http://not-registered.example.com/alice/").should be_false
    end
  end
end

describe SkipEmbedded::OpFixation, "serversを指定しない場合", :type => :model do
  before(:all) do
    SkipEmbedded::OpFixation.servers = []
  end

  it "http://not-registered.example.com/alice/での問い合わせを許可すること" do
    SkipEmbedded::OpFixation.accept?("http://not-registered.example.com/alice/").should be_true
  end
end
