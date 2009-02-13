class ThemeGenerator < Rails::Generator::Base
  
  default_options :theme => :default,
                  :no_layout => false
    
  def initialize(runtime_args, runtime_options = {})
    super
    @name = @args.first || 'application'
  end
  
  def manifest
    record do |m|            
      m.directory("app/views/layouts")
      m.directory("public/stylesheets/themes/#{options[:theme]}/")      
      m.template("view_layout.html.erb", File.join("app/views/layouts", "#{@name}.html.erb")) unless options[:no_layout]
      m.template("../../../stylesheets/base.css",  File.join("public/stylesheets", "web_app_theme.css"))
      m.template("../../../stylesheets/themes/#{options[:theme]}/style.css",  File.join("public/stylesheets/themes/#{options[:theme]}", "style.css"))      
    end
  end
  
  def banner
    "Usage: #{$0} theme [layout_name] [options]"
  end

protected

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("-m", "--theme=theme", String, "Specify the theme") { |v| options[:theme] = v }
    opt.on("--no-layout", "Don't create layout") { |v| options[:no_layout] = true }
  end
  
end
