Feature: Theme generation
	In order to create a great application
	I should be able to creare theme after creating a layout
	
	# script/generate themed posts
	Scenario: Creating CRUD views with controller path
		Given I have a new rails app
                And I have a model named "post"
                When I run the themed generator for the "posts" controller
		Then I should have a view named "posts/index.html.erb"
		And I should have a view named "posts/new.html.erb"
		And I should have a view named "posts/show.html.erb"
		And I should have a view named "posts/edit.html.erb"
	
	# script/generate themed items Post
	Scenario: Creating CRUD views with controller path and model name
		Given I have a new rails app
		And I have a model named "post"
                When I run the themed generator for the "items" controller with the model "post"
		Then I should have a view named "items/index.html.erb"
		And I should have a view named "items/new.html.erb"
		And I should have a view named "items/show.html.erb"
		And I should have a view named "items/edit.html.erb"
  
  # script/generate themed admin/items Post
	Scenario: Creating CRUD views with controller path "admin/items" and model name
		Given I have a new rails app
		And I have a model named "post"
                When I run the themed generator for the "admin/items" controller with the model "post"
		Then I should have a view named "admin/items/index.html.erb"
		And I should have a view named "admin/items/new.html.erb"
		And I should have a view named "admin/items/show.html.erb"
		And I should have a view named "admin/items/edit.html.erb"
	
	# script/generate themed admin/gallery_pictures
	Scenario: Creating CRUD views with controller path "admin/gallery_pictures"
		Given I have a new rails app
                And I have a model named "GalleryPicture"
                When I run the themed generator for the "admin/gallery_pictures" controller
		Then I should have a view named "admin/gallery_pictures/index.html.erb"
		And I should have a view named "admin/gallery_pictures/new.html.erb"
		And I should have a view named "admin/gallery_pictures/show.html.erb"
		And I should have a view named "admin/gallery_pictures/edit.html.erb"
	
	# script/generate themed homes --type=text
	Scenario: Creating text theme
	  Given I have a new rails app
          When I run the themed generator for the "homes" controller with the option --"themed_type"="text"
	  Then I should have a view named "homes/show.html.erb"
	  And I should have a view named "homes/_sidebar.html.erb"
	  
	  
