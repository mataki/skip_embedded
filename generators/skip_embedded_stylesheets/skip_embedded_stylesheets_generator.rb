class SkipEmbeddedStylesheetsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      assets = %w[
        public/stylesheets/skip_base.css
        public/stylesheets/skip_embedded.css
        public/stylesheets/skip_footer.css
        public/stylesheets/skip_header.css
        public/stylesheets/sass/skip_base.sass
        public/stylesheets/sass/skip_embedded.sass
        public/stylesheets/sass/skip_footer.sass
        public/stylesheets/sass/skip_header.sass
        public/stylesheets/sprites/sprites.css
        public/stylesheets/sprites/sprites.png
      ]

      assets.map{|asset| File.dirname(asset) }.uniq.each{|asset| m.directory(asset) }
      assets.each{|asset| m.file asset, asset }
    end
  end
end
