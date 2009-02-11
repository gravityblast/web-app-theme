class LayoutThemeGenerator < Rails::Generator::Base
    
  def initialize(runtime_args, runtime_options = {})
    super
    @name = @args.first || 'application'
  end
  
  def manifest
    record do |m|      
      m.directory('app/views/layouts')      
      m.directory('public/stylesheets/themes/default')
      m.template('view_layout.html.erb', File.join("app/views/layouts", "#{@name}.html.erb"))
      m.template('css_base.css',  File.join("public/stylesheets", "web_app_theme.css"))
      m.template('css_default.css',  File.join("public/stylesheets/themes/default", "style.css"))      
    end
  end
  
  def banner
    "Usage: #{$0} layout_theme [layout_name]"
  end
  
end
