Feature: Theme generation
	In order to create a great application
	I should be able to creare theme after creating a layout
	
	# script/generate themed posts
	Scenario: Creating CRUD views with controller path
		Given I have a new rails app
		And a model "Post"
		When I generate views for controller "posts"
		Then I should have a view named "posts/index.html.erb"
		And I should have a view named "posts/new.html.erb"
		And I should have a view named "posts/show.html.erb"
		And I should have a view named "posts/edit.html.erb"
	
	# script/generate themed items Post
	Scenario: Creating CRUD views with controller path and model name
		Given I have a new rails app
		And a model "Post"
		When I generate views for controller "items" and model "Post"
		Then I should have a view named "items/index.html.erb"
		And I should have a view named "items/new.html.erb"
		And I should have a view named "items/show.html.erb"
		And I should have a view named "items/edit.html.erb"
  
  # script/generate themed admin/items Post
	Scenario: Creating CRUD views with controller path "admin/items" and model name
		Given I have a new rails app
		And a model "Post"
		When I generate views for controller "admin/items" and model "Post"
		Then I should have a view named "admin/items/index.html.erb"
		And I should have a view named "admin/items/new.html.erb"
		And I should have a view named "admin/items/show.html.erb"
		And I should have a view named "admin/items/edit.html.erb"
	
	# script/generate themed admin/gallery_pictures
	Scenario: Creating CRUD views with controller path "admin/gallery_pictures"
		Given I have a new rails app
		And a model "GalleryPicture"
		When I generate views for controller "admin/gallery_pictures"
		Then I should have a view named "admin/gallery_pictures/index.html.erb"
		And I should have a view named "admin/gallery_pictures/new.html.erb"
		And I should have a view named "admin/gallery_pictures/show.html.erb"
		And I should have a view named "admin/gallery_pictures/edit.html.erb"
	
	# script/generate themed homes --type=text
	Scenario: Creating text theme
	  Given I have a new rails app
	  When I generate text views for "homes"
	  Then I should have a view named "homes/show.html.erb"
	  And I should have a view named "homes/_sidebar.html.erb"
	  
	  