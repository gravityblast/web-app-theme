module WebAppTheme
  class ThemeGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    
    argument :layout_name, :type => :string, :default => 'application'
    
    class_option :theme,        :type => :string,   :default => :default,   :desc => 'Specify the layout theme'
    class_option :app_name,     :type => :string,   :default => 'Web App',  :desc => 'Specify the application name'
    class_option :engine,       :type => :string,   :default => 'erb',      :desc => 'Specify the template engine'
    class_option :no_layout,    :type => :boolean,  :default => false,      :desc => 'Use this option if you want to generate only stylesheets'
    class_option :layout_type,  :type => :string,   :default => 'admin',    :desc => 'Layout type, admin or sign'
    
    def copy_layout
      return if options.no_layout      
      admin_layout_name = options.layout_type == 'sign' ? "layout_sign.html.erb" : "layout_admin.html.erb"
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
    
    def copy_images
      directory "#{images_path}", "public/images/web-app-theme"
    end
    
  protected
  
    def stylesheets_path
      "../../../../../stylesheets"
    end
    
    def images_path
      "../../../../../images"
    end
    
    def generate_haml_layout(admin_layout_name)
      require 'haml'
      Dir.mktmpdir('web-app-theme-haml') do |haml_root|
        tmp_html_path = "#{haml_root}/#{admin_layout_name}"
        tmp_haml_path = "#{haml_root}/#{admin_layout_name}.haml"
        template admin_layout_name, tmp_html_path, :verbose => false
        `html2haml --erb --xhtml #{tmp_html_path} #{tmp_haml_path}`
        copy_file tmp_haml_path, "app/views/layouts/#{layout_name.underscore}.html.haml"
      end
    rescue LoadError
      say "HAML is not installed, or it is not specified in your Gemfile."
      exit
    end
  end
end
