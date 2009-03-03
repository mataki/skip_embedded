#!/usr/bin/env ruby
# vim:set fileencoding=utf-8 filetype=ruby

require File.expand_path("../../spec_helper", File.dirname(__FILE__))
require 'skip_collabo/fulltext_search_cache/builder_base'

describe SkipCollabo::FulltextSearchCache::BuilderBase, :type => :model do
  before do
    @url_writer = mock("url_writer")

    SkipCollabo::FulltextSearchCache::BuilderBase.stub!(:url_writer).and_return(@url_writer)
    SkipCollabo::FulltextSearchCache::BuilderBase.entity_name = "target"

    @it = SkipCollabo::FulltextSearchCache::BuilderBase.new("--- entity ---")
    @it.stub!(:root_url).and_return("http://asset.example.com/")
  end

  it{ @it.target.should == "--- entity ---" }

  it{ @it.icon_url.should == "http://asset.example.com/images/icons/target.gif" }

  it "to_metaはovverrideしてつかうこと" do
    lambda{ @it.to_meta }.should raise_error(NotImplementedError)
  end
  it "titleはovverrideしてつかうこと" do
    lambda{ @it.title }.should raise_error(NotImplementedError)
  end
  it "bodyはovverrideしてつかうこと" do
    lambda{ @it.body }.should raise_error(NotImplementedError)
  end

  it "write_metaは、mediatorが返すパスにto_meta.to_yamlを書き込むこと" do
    File.should_receive(:open).with("path", "wb").and_yield(fd = mock("fd"))
    fd.should_receive(:write).with("--- meta ---".to_yaml)

    mediator = mock("mediator")
    mediator.should_receive(:meta_path).and_return("path")

    @it.should_receive(:to_meta).and_return("--- meta ---")

    @it.write_meta(mediator)
  end
end

