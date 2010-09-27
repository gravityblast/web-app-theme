module WebAppTheme
  class ThemeGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)
    
    argument :layout_name, :type => :string, :default => 'application'
    
    class_option :theme,    :type => :string, :default => :default,   :desc => 'Specify the layout theme'
    class_option :app_name, :type => :string, :default => 'Web App',  :desc => 'Specify the application name'
    class_option :engine,   :type => :string, :default => 'erb',      :desc => 'Specify the template engine'
    
    def copy_layout
      admin_layout_name = "layout_admin.html.erb"
      case options.engine
      when 'erb'
        template  admin_layout_name, "app/views/layouts/#{layout_name.underscore}.html.erb"
      when 'haml'
        generate_haml_layout(admin_layout_name)        
      end                  
    end

    def copy_base_stylesheets
      copy_file "#{stylesheets_path}/base.css",     "public/stylesheets/web-app-theme/base.css"
      copy_file "#{stylesheets_path}/override.css", "public/stylesheets/web-app-theme/override.css"
    end
    
    def copy_theme_stylesheets
      directory "#{stylesheets_path}/themes/#{options.theme}", "public/stylesheets/web-app-theme/themes/#{options.theme}"
    end
    
  protected
  
    def stylesheets_path
      "../../../../stylesheets"
    end
    
    def generate_haml_layout(admin_layout_name)
      require 'haml'
      Dir.mktmpdir('web-app-theme-haml') do |haml_root|
        tmp_html_path = "#{haml_root}/#{admin_layout_name}"
        tmp_haml_path = "#{haml_root}/#{admin_layout_name}.haml"
        template admin_layout_name, tmp_html_path, :verbose => false
        `html2haml -r #{tmp_html_path} #{tmp_haml_path}`
        copy_file tmp_haml_path, "app/views/layouts/#{layout_name.underscore}.html.haml"
      end
    rescue LoadError
      say "HAML is not installed, or it is not specified in your Gemfile."
      exit
    end
  end
end