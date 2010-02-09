class ThemedGenerator < Rails::Generator::NamedBase
  
  default_options :app_name => 'Web App',
                  :themed_type => :crud,
                  :layout => false,
                  :will_paginate => false,
                  :engine => :erb
  
  attr_reader :controller_routing_path, 
              :singular_controller_routing_path,
              :columns,
              :model_name,
              :plural_model_name,
              :resource_name,
              :plural_resource_name,
              :engine
  
  def initialize(runtime_args, runtime_options = {})
    super
    @controller_path  = runtime_args.shift
    @model_name       = runtime_args.shift
    @engine           = options[:engine]
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
    @resource_name        = @model_name.underscore 
    # posts
    @plural_resource_name = @resource_name.pluralize                
    
    manifest_method = "manifest_for_#{options[:themed_type]}"
    record do |m|
      send(manifest_method, m) if respond_to?(manifest_method)
    end
  end
  
protected
  
  def manifest_for_crud(m)
    @columns = get_columns
    m.directory(File.join('app/views', @controller_file_path))                        
    m.template("view_tables.html.#{@engine}",  File.join("app/views", @controller_file_path, "index.html.#{@engine}"))
    m.template("view_new.html.#{@engine}",     File.join("app/views", @controller_file_path, "new.html.#{@engine}"))
    m.template("view_edit.html.#{@engine}",    File.join("app/views", @controller_file_path, "edit.html.#{@engine}"))
    m.template("view_form.html.#{@engine}",    File.join("app/views", @controller_file_path, "_form.html.#{@engine}"))
    m.template("view_show.html.#{@engine}",    File.join("app/views", @controller_file_path, "show.html.#{@engine}"))
    m.template("view_sidebar.html.#{@engine}", File.join("app/views", @controller_file_path, "_sidebar.html.#{@engine}"))
    
    if options[:layout]
      #TODO fix this for haml
      m.gsub_file(File.join("app/views/layouts", "#{options[:layout]}.html.#{@engine}"), /\<div\s+id=\"main-navigation\">.*\<\/ul\>/mi) do |match|
        match.gsub!(/\<\/ul\>/, "")
        if @engine.to_s =~ /haml/
          %|#{match}
        %li{:class => controller.controller_path == '#{@controller_file_path}' ? 'active' : '' }
          %a{:href => #{controller_routing_path}_path} #{plural_model_name}
        </ul>|
        else
          %|#{match} <li class="<%= controller.controller_path == '#{@controller_file_path}' ? 'active' : '' %>"><a href="<%= #{controller_routing_path}_path %>">#{plural_model_name}</a></li></ul>|
        end
      end
    end
  end
  
  def manifest_for_restful_authentication(m)
    signup_controller_path  = @controller_file_path
    signin_controller_path  = @model_name.downcase # just here I use the second argument as a controller path
    @resource_name          = @controller_path.singularize
    m.template("view_signup.html.#{@engine}",  File.join("app/views", signup_controller_path, "new.html.#{@engine}"))
    m.template("view_signin.html.#{@engine}",  File.join("app/views", signin_controller_path, "login.html.#{@engine}"))
  end
  
  def manifest_for_text(m)
    m.directory(File.join('app/views', @controller_file_path))    
    m.template("view_text.html.#{@engine}", File.join("app/views", @controller_file_path, "show.html.#{@engine}"))
    m.template("view_sidebar.html.#{@engine}", File.join("app/views", @controller_file_path, "_sidebar.html.#{@engine}"))
  end
  
  def get_columns
    excluded_column_names = %w[id created_at updated_at]
    Kernel.const_get(@model_name).columns.reject{|c| excluded_column_names.include?(c.name) }.collect{|c| Rails::Generator::GeneratedAttribute.new(c.name, c.type)}
  end
  
  def banner
    "Usage: #{$0} themed ControllerPath [ModelName] [options]"
  end
  
  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("--app_name=app_name", String, "") { |v| options[:app_name] = v }
    opt.on("--type=themed_type", String, "") { |v| options[:themed_type] = v }    
    opt.on("--layout=layout", String, "Add menu link") { |v| options[:layout] = v }
    opt.on("--with_will_paginate", "Add pagination using will_paginate") { |v| options[:will_paginate] = true }
    opt.on("--engine=haml", "Use HAML instead of ERB template engine") { |v| options[:engine] = v }
  end
  
end
