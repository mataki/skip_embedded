require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'skip_collabo/fulltext_search_cache'

describe SkipCollabo::FulltextSearchCache, "new('path/to/cache/root', :since => 15.seconds.ago)", :type => :model do
  before do
    @fts_cache = SkipCollabo::FulltextSearchCache.new(:cache_dir => 'path/to/cache/root/app_cache', :url_prefix => "http://example.com", :since => 15.seconds.ago)
  end

  it{ @fts_cache.cache_dir.should == 'path/to/cache/root/app_cache' }

  describe "出力先パスの算出" do
    before do
      @builder = mock("builder")
      @builder.should_receive(:filename).and_return "file.html"
    end

    it do
      @fts_cache.cache_path(@builder).should == "#{Dir.pwd}/path/to/cache/root/app_cache/file.html"
    end

    it do
      @fts_cache.meta_path(@builder).should == "#{Dir.pwd}/path/to/cache/root/app_cache_meta/file.html"
    end
  end
end

