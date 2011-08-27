module WebAppTheme
    class AssetsGenerator < Rails::Generators::Base
      desc "Copy the --theme stylesheets to your rails application assets path, so you can customize them"
      source_root File.expand_path('../../../../../app/assets/', __FILE__)
      class_option :theme,        :type => :string,   :default => :default,   :desc => 'Specify the layout theme to be copied'

      def copy_stylesheets
        copy_file "stylesheets/web-app-theme/base.css"                , "app/assets/stylesheets/web-app-theme/base.css"
        directory "stylesheets/web-app-theme/themes/#{options.theme}" , "app/assets/stylesheets/web-app-theme/themes/#{options.theme}"
      end

      def copy_images
        directory "images/web-app-theme/themes/#{options.theme}"      , "app/assets/images/web-app-theme/themes/#{options.theme}"
      end

    end
  end
