module WebAppTheme
  class ThemeGenerator < ::Rails::Generators::Base
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
      copy_file "#{stylesheets_path}/base.css",     File.join(rails_assets_root, "stylesheets/web-app-theme/base.css")
      copy_file "#{stylesheets_path}/override.css", File.join(rails_assets_root, "stylesheets/web-app-theme/override.css")
    end
    
    def copy_theme_stylesheets
      if rails31?
        copy_file "#{stylesheets_path}/themes/#{options.theme}/style.css",  File.join(rails_assets_root, "stylesheets/web-app-theme/themes/#{options.theme}/style.css")

        # for rails 3.1 fonts are served from /app/assets/images/fonts
        directory "#{stylesheets_path}/themes/#{options.theme}/fonts",  File.join(rails_assets_root, "images", "fonts") rescue nil

        # for rails 3.1, images are served from /app/assets/images
        # but in the style sheets is constantly referred to `images/something.jpg`, so we must double-nest
        # This is the easies way for now to keep the stylesheets rails 3.0 and rails 3.1 compatible
        directory "#{stylesheets_path}/themes/#{options.theme}/images",  File.join(rails_assets_root, "images", "images") rescue nil
      else
        directory "#{stylesheets_path}/themes/#{options.theme}",  File.join(rails_assets_root, "stylesheets/web-app-theme/themes/#{options.theme}")
      end
    end
    
    def copy_images
      directory "#{images_path}",  File.join(rails_assets_root,"images/web-app-theme")
    end
    
  protected

    def stylesheets_path
      "../../../../../stylesheets"
    end
    
    def images_path
      "../../../../../images"
    end

    def rails_assets_root
      @rails_assets_root ||= if rails31?
                              'app/assets'
                            else
                              'public'
                            end
    end

    def rails31?
      ::Rails.version[0..2].to_f >= 3.1
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
