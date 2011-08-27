module WebAppTheme
  module Assets
    class StylesheetsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../../../app/assets/stylesheets', __FILE__)

      def copy_stylesheets
        directory "web-app-theme", "app/assets/stylesheets/web-app-theme" 
      end

    end
  end
end
