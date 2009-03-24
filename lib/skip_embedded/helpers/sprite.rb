module SkipEmbedded
  module Helpers
    module Sprite
      NBSP = '&nbsp;'

      def icon_tag(name, options = {})
        margin = options.delete(:margin)
        result = content_tag(:span, NBSP, {:class =>"ss_sprite ss_#{name}"}.merge(options))
        margin ? result << NBSP : result
      end
    end
  end
end
