$:.unshift(File.dirname(__FILE__) + "/../../rails_generators")
require "rubygems"
require "rails_generator"
require 'rails_generator/scripts/generate'
require "fileutils"
require "theme/theme_generator"

web_app_theme_root      = File.join(File.dirname(__FILE__), "/../../")
tmp_rails_app_name  = "tmp_rails_project"
tmp_rails_app_root  = File.join(web_app_theme_root, tmp_rails_app_name)

Rails::Generator::Base.append_sources(Rails::Generator::PathSource.new(:builtin, "#{web_app_theme_root}/rails_generators/"))

module GeneratorHelpers
  def generate_rails_app
    FileUtils.mkdir(File.join(@app_root))
  end    
  
  def remove_layouts
    FileUtils.rm_rf(File.join(@app_root, "app", "views", "layouts"))
  end
  
  def remove_stylesheets
    FileUtils.rm_rf(File.join(@app_root, "public", "stylesheets"))
  end
  
  def generate_layout(*args)
    options = !args.empty? && args.last.is_a?(Hash) ? args.pop : {}
    options.merge!({:destination => @app_root, :quiet => true})    
    Rails::Generator::Scripts::Generate.new.run(args, options)
  end
  
  def layouts_count
    Dir[File.join(@app_root, "app", "views", "layouts", "**", "*.erb")].size
  end
  
  def layout_exists?(filename)
    File.exists?(File.join(@app_root, "app", "views", "layouts", filename))
  end
  
  def stylesheet_exists?(relative_path)
    File.exists?(File.join(@app_root, "public", "stylesheets", relative_path)).should be_true
  end
  
  def layout_title(layout)
    File.open(File.join(@app_root, "app", "views", "layouts", layout), "r").read.match(/<title>([^<]*)<\/title>/)[1]
  end
  
  def layout_with_box?(layout)
    File.open(File.join(@app_root, "app", "views", "layouts", layout), "r").read =~ /<div id=\"box\">/
  end
end

Before do
  @app_root = tmp_rails_app_root  
end

After do
  FileUtils.rm_rf(tmp_rails_app_root)
end

World(GeneratorHelpers)