require File.dirname(__FILE__) + "/spec_helper"

describe ThemedGenerator, "with 'script/generate themed posts'" do 
  before do
    Post = Class.new
    Post.stub!(:columns).and_return([])
    options = {:destination => File.dirname(__FILE__), :quiet => true, :source => File.dirname(__FILE__)}
    @generator = ThemedGenerator.new(["posts", "post"], options)
    @generator.manifest
  end
  
  after do
    Object::send(:remove_const, :Post)
  end
  
  it "should set the right controller_routing_path" do            
    @generator.instance_variable_get("@controller_routing_path").should == "posts"
  end
  
  it "should set the right singular_controller_routing_path" do
    @generator.instance_variable_get("@singular_controller_routing_path").should == "post"
  end
  
  it "should set the right model_name" do
    @generator.instance_variable_get("@model_name").should == "Post"
  end
  
  it "should set the right plural_model_name" do
    @generator.instance_variable_get("@plural_model_name").should == "Posts"
  end

  it "should set the right resource_name" do
    @generator.instance_variable_get("@resource_name").should == "post"
  end
  
  it "should set the right plural_resource_name" do
    @generator.instance_variable_get("@plural_resource_name").should == "posts"
  end      
end

describe ThemedGenerator, "with 'script/generate themed admin/gallery_items'" do 
  before do
    GalleryItem = Class.new
    GalleryItem.stub!(:columns).and_return([])
    options = {:destination => File.dirname(__FILE__), :quiet => true, :source => File.dirname(__FILE__)}
    @generator = ThemedGenerator.new(["admin/gallery_items"], options)
    @generator.manifest
  end
  
  after do
    Object::send(:remove_const, :GalleryItem)
  end
  
  it "should set the right controller_routing_path" do            
    @generator.instance_variable_get("@controller_routing_path").should == "admin_gallery_items"
  end
  
  it "should set the right singular_controller_routing_path" do
    @generator.instance_variable_get("@singular_controller_routing_path").should == "admin_gallery_item"
  end
  
  it "should set the right model_name" do
    @generator.instance_variable_get("@model_name").should == "GalleryItem"
  end
  
  it "should set the right plural_model_name" do
    @generator.instance_variable_get("@plural_model_name").should == "GalleryItems"
  end

  it "should set the right resource_name" do
    @generator.instance_variable_get("@resource_name").should == "gallery_item"
  end
  
  it "should set the right plural_resource_name" do
    @generator.instance_variable_get("@plural_resource_name").should == "gallery_items"
  end      
end

describe ThemedGenerator, "with 'script/generate themed admin/gallery_items pictures'" do 
  before do
    Picture = Class.new
    Picture.stub!(:columns).and_return([])
    options = {:destination => File.dirname(__FILE__), :quiet => true, :source => File.dirname(__FILE__)}
    @generator = ThemedGenerator.new(["admin/gallery_items", "picture"], options)
    @generator.manifest
  end
  
  after do
    Object::send(:remove_const, :Picture)
  end
  
  it "should set the right controller_routing_path" do            
    @generator.instance_variable_get("@controller_routing_path").should == "admin_gallery_items"
  end
  
  it "should set the right singular_controller_routing_path" do
    @generator.instance_variable_get("@singular_controller_routing_path").should == "admin_gallery_item"
  end
  
  it "should set the right model_name" do
    @generator.instance_variable_get("@model_name").should == "Picture"
  end
  
  it "should set the right plural_model_name" do
    @generator.instance_variable_get("@plural_model_name").should == "Pictures"
  end

  it "should set the right resource_name" do
    @generator.instance_variable_get("@resource_name").should == "picture"
  end
  
  it "should set the right plural_resource_name" do
    @generator.instance_variable_get("@plural_resource_name").should == "pictures"
  end      
end
