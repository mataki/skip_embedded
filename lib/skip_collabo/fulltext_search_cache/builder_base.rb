
module SkipCollabo
  module FulltextSearchCache
    class BuilderBase
      include ActionController::UrlWriter
      class_inheritable_accessor :entity_name

      def initialize(entity)
        @entity = entity
      end

      def filename
        "#{entity_name}/#{@entity.id}.html"
      end

      def write_cache(mediator)
        File.open(mediator.cache_path(self), "wb"){|f| f.write to_cache }
      end

      def to_cache
        ERB.new(<<-HTML).result(binding)
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>#{title}</title>
  </head>
  <body>#{body}</body>
</html>
HTML
      end

      def write_meta(mediator)
        File.open(mediator.meta_path(self), "wb"){|f| f.write to_meta.to_yaml }
      end

      def to_meta; raise NotImplementedError, "ovverride me" end
      def title; raise NotImplementedError, "ovverride me" end
      def body; raise NotImplementedError, "ovverride me" end

      def icon_url(icon_filename = entity_name + ".gif")
        root_url + "images/icons/" + icon_filename
      end

      private
      def method_missing(m, *args, &block)
        return @entity if m.to_sym == entity_name.to_sym
        super
      end
    end
  end
end
