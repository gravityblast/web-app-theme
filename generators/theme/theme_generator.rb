class ThemeGenerator < Rails::Generator::NamedBase
  
  default_options :menu => false
  
  attr_reader :controller_routing_path, 
              :singular_controller_routing_path,
              :columns,
              :model_name,
              :plural_model_name,
              :resource_name,
              :plural_resource_name
  
  def initialize(runtime_args, runtime_options = {})
    super
    @controller_path  = runtime_args.shift
    @model_name       = runtime_args.shift   
  end
  
  def manifest
    @controller_routing_path          = @table_name    
    @singular_controller_routing_path = @table_name.singularize    
    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_path)    
    @model_name = base_name.singularize unless @model_name
    
    # Post
    @model_name           = @model_name.camelize 
    # Posts
    @plural_model_name    = @model_name.pluralize
    # post 
    @resource_name        = @model_name.downcase 
    # posts
    @plural_resource_name = @resource_name.pluralize 
            
    @columns = get_columns
          
    record do |m|      
      m.directory('app/views/layouts')
      m.directory('public/stylesheets/themes/default')
      m.directory(File.join('app/views', @controller_file_path))                        
      m.template('view_layout.html.erb', File.join("app/views/layouts", "web_app_theme.html.erb"))
      m.template('view_tables.html.erb',  File.join("app/views", @controller_file_path, "index.html.erb"))
      m.template('view_new.html.erb',  File.join("app/views", @controller_file_path, "new.html.erb"))
      m.template('view_sidebar.html.erb',  File.join("app/views", @controller_file_path, "_sidebar.html.erb"))
      m.template('css_base.css',  File.join("public/stylesheets", "web_app_theme.css"))
      m.template('css_default.css',  File.join("public/stylesheets/themes/default", "style.css"))
      # If layout exists and it's not overridden, it adds just the menu link.
      m.gsub_file(File.join("app/views/layouts", "web_app_theme.html.erb"), /\<div\s+id=\"main-navigation\">.*\<\/ul\>/mi) do |match|
        match.gsub!(/\<\/ul\>/, "")
        %|#{match} <li><a href="<%= #{plural_resource_name}_path %>">#{plural_model_name}</a></li></ul>|
      end
    end
  end
  
protected

  def get_columns
    excluded_column_names = %w[id created_at updated_at]
    Kernel.const_get(@model_name).columns.reject{|c| excluded_column_names.include?(c.name) }.collect{|c| Rails::Generator::GeneratedAttribute.new(c.name, c.type)}
  end
  
  def banner
    "Usage: #{$0} theme ControllerPath [ModelName]"
  end
  
  # def add_options!(opt)
  #   opt.separator ''
  #   opt.separator 'Options:'
  #   opt.on("--menu", "Add menu link") { |v| options[:menu] = true }
  # end
  
end
