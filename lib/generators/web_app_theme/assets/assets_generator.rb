module WebAppTheme
    class AssetsGenerator < Rails::Generators::Base
      desc "Copy the --theme stylesheets to your rails application assets path, so you can customize them"
      source_root File.expand_path('../../../../../app/assets/', __FILE__)
      class_option :theme,        :type => :string,   :default => :default,   :desc => 'Specify the layout theme to be copied'

      def copy_stylesheets
        assets_base = ("app/assets/stylesheets" if Rails.version >= "3.1.0") || "public/stylesheets"
        copy_file "stylesheets/web-app-theme/base.css"                , "#{assets_base}/web-app-theme/base.css"
        directory "stylesheets/web-app-theme/themes/#{options.theme}" , "#{assets_base}/web-app-theme/themes/#{options.theme}"

        # Removing the .ERB and placing a compiled style.css in it's place when the rails version is < 3.1.0
        if Rails.version < "3.1.0"
          remove_file "#{assets_base}/web-app-theme/themes/#{options.theme}/style.css.erb"
          template  "stylesheets/web-app-theme/themes/#{options.theme}/style.css.erb", "#{assets_base}/web-app-theme/themes/#{options.theme}/style.css"
        end
      end

      def copy_images
        assets_base = ("app/assets/images" if Rails.version >= "3.1.0") || "public/stylesheets"
        directory "images/web-app-theme/icons"                        , "#{assets_base}/web-app-theme/icons"
        copy_file "images/web-app-theme/avatar.png"                   , "#{assets_base}/web-app-theme/avatar.png"
        directory "images/web-app-theme/themes/#{options.theme}"      , "#{assets_base}/web-app-theme/themes/#{options.theme}"
      end

      private

      def asset_path(source, default_ext = nil, body = false)
        "/stylesheets/#{source}"
      end


    end
  end
