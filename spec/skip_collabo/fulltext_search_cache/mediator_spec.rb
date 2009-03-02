require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'skip_collabo/fulltext_search_cache/mediator'

describe SkipCollabo::FulltextSearchCache, "new('path/to/cache/root', :since => 15.seconds.ago)", :type => :model do
  before do
    @fts_cache = SkipCollabo::FulltextSearchCache::Mediator.new(:cache_dir => 'path/to/cache/root/app_cache', :url_prefix => "http://example.com", :since => 15.seconds.ago)
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

  describe "#build" do

    before do
      @model_klass = mock("model_klass")
      @model_klass.should_receive(:name).and_return "MdelClass"
      @model_klass.should_receive(:quoted_table_name).and_return "mdoel_classes"
      @model_klass.should_receive(:scoped).and_return( [model_obj = mock("model_obj")] )
      model_obj.should_receive(:id).and_return("--id--")

      SkipCollabo::FulltextSearchCache::PartialLoader.should_receive(:new).with([model_obj], 1000).and_return(loader = mock("loader"))
      loader.should_receive(:each).and_yield( model_obj )

      @builder_klass = mock("builder_klass")
      @builder_klass.should_receive(:new).with( model_obj ).and_return( builder = mock("builder") )
      builder.should_receive(:write_cache).with(@fts_cache)
      builder.should_receive(:write_meta).with(@fts_cache)
    end

    it do
      @fts_cache.build(@model_klass, @builder_klass)
    end
  end
end

