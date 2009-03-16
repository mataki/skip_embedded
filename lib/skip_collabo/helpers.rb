module SkipEmbedded
  module Helpers
    include Ui

    def self.included(base)
      ActionView::Helpers::AssetTagHelper.register_javascript_expansion :skip => %w[dropdown_navigation labeled_text_field]
      ActionView::Helpers::AssetTagHelper.register_javascript_expansion :skip_fckeditor => %w[fckeditor/fckeditor skip_fckeditor_config]

      # TODO skip/style などをどの程度共通化するかを検討、それはではskip_collaboという別名で
      ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :skip_collabo => %w[skip_collabo]
    end
  end
end
