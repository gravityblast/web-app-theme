module WebAppTheme
  class ThemeGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)
    
    argument :layout_name, :type => :string, :default => 'application'
    
    class_option :theme, :type => :string, :default => :default, :desc => 'Specify the layout theme'
    class_option :app_name, :type => :string, :default => 'Web App', :desc => 'Specify the application name'
    
    def copy_layout
      template("layout_admin.html.erb", "app/views/layouts/#{layout_name.underscore}.html.erb")
    end
  end
end
