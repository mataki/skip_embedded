module SkipEmbedded
  module Helpers
    module Ui

      def sanitize_richtext(content)
        allowed_tags = HTML::WhiteListSanitizer.allowed_tags.dup << "table" << "tbody" << "tr" << "th" << "td" << "caption" << "strike"
        allowed_attributes = HTML::WhiteListSanitizer.allowed_attributes.dup << "style" << "cellspacing" << "cellpadding" << "border" << "align" << "summary"
        sanitize(content, :tags => allowed_tags, :attributes => allowed_attributes)
      end

      # From. http://github.com/mojombo/clippy/tree/master
      def clippy(copy_text, bgcolor='#FFFFFF')
        html = <<-EOF
          <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
                  width="110"
                  height="14"
                  id="clippy" >
          <param name="movie" value="#{flash_path("clippy")}"/>
          <param name="allowScriptAccess" value="always" />
          <param name="quality" value="high" />
          <param name="scale" value="noscale" />
          <param NAME="FlashVars" value="text=#{copy_text}">
          <param name="bgcolor" value="#{bgcolor}">
          <embed src="#{flash_path("clippy")}"
                 width="110"
                 height="14"
                 name="clippy"
                 quality="high"
                 allowScriptAccess="always"
                 type="application/x-shockwave-flash"
                 pluginspage="http://www.macromedia.com/go/getflashplayer"
                 FlashVars="text=#{copy_text}"
                 bgcolor="#{bgcolor}"
          />
          </object>
        EOF
      end

      def render_flash(type)
        if message = flash[type]
          content_tag("div", :class => type.to_s) do
            content_tag("h3", h(message) + content_tag("span", _("[Click to hide]")))
          end
        end
      end

      def flash_path(source, suffix="swf")
        compute_public_path(source, "flash", suffix)
      end
    end
  end
end

