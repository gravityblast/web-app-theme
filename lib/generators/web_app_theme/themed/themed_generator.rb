require 'rails/generators/generated_attribute'

module WebAppTheme
  class ThemedGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
        
    argument :controller_path,  :type => :string
    argument :model_name,       :type => :string, :required => false    
    
    class_option :layout,         :type => :string,   :desc => 'Specify the layout name'
    class_option :engine,         :type => :string,   :default => 'erb', :desc => 'Specify the template engine'
    class_option :will_paginate,  :type => :boolean,  :default => false, :desc => 'Specify if you use will_paginate'
    class_option :themed_type,    :type => :string,   :default => 'crud', :desc => 'Specify the themed type, crud or text. Default is crud'
    
    def initialize(args, *options)
      super(args, *options)
      initialize_views_variables
    end
    
    def copy_views
      generate_views      
      unless options.layout.blank?
        if options.engine =~ /erb/
          gsub_file(File.join('app/views/layouts', "#{options[:layout]}.html.#{options.engine}"), /\<div\s+id=\"main-navigation\">.*\<\/ul\>/mi) do |match|
            match.gsub!(/\<\/ul\>/, "")
            %|#{match} <li class="<%= controller.controller_path == '#{@controller_file_path}' ? 'active' : '' %>"><a href="<%= #{controller_routing_path}_path %>">#{plural_model_name}</a></li></ul>|
          end
        elsif options.engine =~ /haml/
          gsub_file(File.join('app/views/layouts', "#{options[:layout]}.html.#{options.engine}"), /#main-navigation.*#wrapper.wat-cf/mi) do |match|
            match.gsub!(/      #wrapper.wat-cf/, "")
            %|#{match}| +
            "  "*6 + %|%li{:class => controller.controller_path == '#{@controller_file_path}' ? 'active' : '' }\n| +
            "  "*7 + %|%a{:href => #{controller_routing_path}_path} #{plural_model_name}\n| +
            "  "*3 + %|#wrapper.wat-cf|
          end
        end
      end
    end

  protected
    
    def initialize_views_variables
      @base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(controller_path)
      @controller_routing_path = @controller_file_path.gsub(/\//, '_')
      @model_name = @base_name.singularize unless @model_name
      @model_name = @model_name.camelize
    end
    
    def controller_routing_path
      @controller_routing_path
    end
    
    def singular_controller_routing_path
      @controller_routing_path.singularize
    end
    
    def model_name
      @model_name
    end
    
    def plural_model_name
      @model_name.pluralize
    end
    
    def resource_name
      @model_name.underscore
    end
    
    def plural_resource_name
      resource_name.pluralize
    end
    
    ## 
    # Attempts to call #columns on the model's class
    # If the (Active Record) #columns method does not exist, it attempts to
    # perform the (Mongoid) #fields method instead
    def columns
      begin
        excluded_column_names = %w[id created_at updated_at]
        Kernel.const_get(@model_name).columns.reject{|c| excluded_column_names.include?(c.name) }.collect{|c| Rails::Generators::GeneratedAttribute.new(c.name, c.type)} 
      rescue NoMethodError
        Kernel.const_get(@model_name).fields.collect{|c| c[1]}.reject{|c| excluded_column_names.include?(c.name) }.collect{|c| Rails::Generators::GeneratedAttribute.new(c.name, c.type.to_s)}
      end
    end
    
    def extract_modules(name)
      modules = name.include?('/') ? name.split('/') : name.split('::')
      name    = modules.pop
      path    = modules.map { |m| m.underscore }
      file_path = (path + [name.underscore]).join('/')
      nesting = modules.map { |m| m.camelize }.join('::')
      [name, path, file_path, nesting, modules.size]
    end
    
    def generate_views
      views = {
        'crud' => {
          'view_tables.html.erb'  => File.join('app/views', @controller_file_path, "index.html.#{options.engine}"),
          'view_new.html.erb'     => File.join('app/views', @controller_file_path, "new.html.#{options.engine}"),
          'view_edit.html.erb'    => File.join('app/views', @controller_file_path, "edit.html.#{options.engine}"),
          'view_form.html.erb'    => File.join('app/views', @controller_file_path, "_form.html.#{options.engine}"),
          'view_show.html.erb'    => File.join('app/views', @controller_file_path, "show.html.#{options.engine}"),
          'view_sidebar.html.erb' => File.join('app/views', @controller_file_path, "_sidebar.html.#{options.engine}")
        },
        'text' => {
          'view_text.html.erb'    => File.join('app/views', @controller_file_path, "show.html.#{options.engine}"),
          'view_sidebar.html.erb' => File.join('app/views', @controller_file_path, "_sidebar.html.#{options.engine}")
        }
      }
      selected_views = views[options.themed_type]
      options.engine == 'haml' ? generate_haml_views(selected_views) : generate_erb_views(selected_views)
    end
    
    def generate_erb_views(views)
      views.each do |template_name, output_path|
        template template_name, output_path
      end
    end
    
    def generate_haml_views(views)
      require 'haml'
      Dir.mktmpdir('web-app-theme-haml') do |haml_root|
        views.each do |template_name, output_path|
          tmp_html_path = "#{haml_root}/#{template_name}"
          tmp_haml_path = "#{haml_root}/#{template_name}.haml"
          template template_name, tmp_html_path, :verbose => false
          `html2haml --erb --xhtml #{tmp_html_path} #{tmp_haml_path}`
          copy_file tmp_haml_path, output_path
        end
      end
      
    rescue LoadError
      say "HAML is not installed, or it is not specified in your Gemfile."
      exit
    end
  end
end
