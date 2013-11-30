module WebAppTheme
  class DeviseGenerator < Rails::Generators::Base
    desc "Installs devise-specific forms"
    source_root File.expand_path('../templates', __FILE__)
    
    class_option :engine,       :type => :string,   :default => 'erb',      :desc => 'Specify the template engine'
   
    def copy_theme_stylesheets
      directory "devise", "app/views/devise"
    end
     
  protected
  
    def generate_haml_layout(admin_layout_name)
      require 'haml'
      Dir.mktmpdir('web-app-theme-haml') do |haml_root|
        tmp_html_path = "#{haml_root}/#{admin_layout_name}"
        tmp_haml_path = "#{haml_root}/#{admin_layout_name}.haml"
        template admin_layout_name, tmp_html_path, :verbose => false
        `html2haml --erb #{tmp_html_path} #{tmp_haml_path}`
        copy_file tmp_haml_path, "app/views/layouts/#{layout_name.underscore}.html.haml"
      end
    rescue LoadError
      say "HAML is not installed, or it is not specified in your Gemfile."
      exit
    end
  end
end
