class ThemeGenerator < Rails::Generator::Base
  
  default_options :app_name => 'Web App',
                  :layout_type => :administration,
                  :theme => :default,
                  :no_layout => false
    
  def initialize(runtime_args, runtime_options = {})
    super
    @name = @args.first || (options[:layout_type].to_s == "sign" ? "sign" : "application")
  end
  
  def manifest
    record do |m|
      m.directory("app/views/layouts")
      m.directory("public/images/web-app-theme")      
      %w(cross key tick application_edit).each do |icon|
        m.file("../../../images/icons/#{icon}.png", "public/images/web-app-theme/#{icon}.png")
      end            
      m.directory("public/stylesheets/themes/#{options[:theme]}/")
      m.template("view_layout_#{options[:layout_type]}.html.erb", File.join("app/views/layouts", "#{@name}.html.erb")) unless options[:no_layout]
      m.template("../../../stylesheets/base.css",  File.join("public/stylesheets", "web_app_theme.css"))
      m.template("web_app_theme_override.css",  File.join("public/stylesheets", "web_app_theme_override.css"))
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
    opt.on("--app_name=app_name", String, "") { |v| options[:app_name] = v }
    opt.on("--type=layout_type", String, "Specify the layout type") { |v| options[:layout_type] = v }
    opt.on("--theme=theme", String, "Specify the theme") { |v| options[:theme] = v }
    opt.on("--no-layout", "Don't create layout") { |v| options[:no_layout] = true }
  end
  
end
