Feature: Theme generation
	In order to create a great application
	I should be able to creare theme after creating a layout
	
	Scenario: Creating CRUD views with post path
		Given I have a new rails app
		And a model "Post"
		When I generate views for controller "posts"
		Then I should have a view named "posts/index.html.erb"
		And I should have a view named "posts/new.html.erb"
		And I should have a view named "posts/show.html.erb"
		And I should have a view named "posts/edit.html.erb"
		
	Scenario: Creating CRUD views with post path and model path
		Given I have a new rails app
		And a model "Post"
		When I generate views for controller "items" and model "Post"
		Then I should have a view named "items/index.html.erb"
		And I should have a view named "items/new.html.erb"
		And I should have a view named "items/show.html.erb"
		And I should have a view named "items/edit.html.erb"

	Scenario: Creating CRUD views with post path "admin/items" and model path
		Given I have a new rails app
		And a model "Post"
		When I generate views for controller "admin/items" and model "Post"
		Then I should have a view named "admin/items/index.html.erb"
		And I should have a view named "admin/items/new.html.erb"
		And I should have a view named "admin/items/show.html.erb"
		And I should have a view named "admin/items/edit.html.erb"
	
	Scenario: Creating CRUD views with post path "admin/gallery_pictures" and model path
		Given I have a new rails app
		And a model "GalleryPicture"
		When I generate views for controller "admin/gallery_pictures"
		Then I should have a view named "admin/gallery_pictures/index.html.erb"
		And I should have a view named "admin/gallery_pictures/new.html.erb"
		And I should have a view named "admin/gallery_pictures/show.html.erb"
		And I should have a view named "admin/gallery_pictures/edit.html.erb"