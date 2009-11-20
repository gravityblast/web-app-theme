Given /^I have a new rails app$/ do
  generate_rails_app
end

Given /^I have no layouts$/ do
  remove_layouts  
end

Given /^I have no stylesheets$/ do
  remove_stylesheets
end

Given /^I generate a theme$/ do
  generate_layout
end

Given /^I generate a theme with name "([^\"]*)"$/ do |name|
  generate_layout(name)
end

Given /^I generate a theme choosing the "([^\"]*)" theme$/ do |theme_name|
  generate_layout(:theme => theme_name)
end

Then /^I should have a layout named "([^\"]*)"$/ do |filename|
  layout_exists?(filename).should be_true  
end

Then /^I should have a stylesheet named "([^\"]*)"$/ do |filename|
  stylesheet_exists?(filename).should be_true    
end

Then /^I should have an image named "([^\"]*)"$/ do |filename|
  image_exists?(filename).should be_true    
end

Given /^I generate a theme without layout choosing the "([^\"]*)" theme$/ do |theme_name|
  generate_layout(:theme => theme_name, :no_layout => true )
end

Then /^I should not have any layouts$/ do
  layouts_count.should == 0
end

Given /^I generate a theme with application name "([^\"]*)"$/ do |name|
  generate_layout(:app_name => name )
end

Then /^the layout "([^\"]*)" should have "([^\"]*)" as page title$/ do |layout, title|
  layout_title(layout).should == title
end

Given /^I generate a theme for signin and signup$/ do
  generate_layout(:layout_type => :sign)
end

Then /^I should have a layout named "([^\"]*)" with just a box$/ do |layout|
  layout_with_box?(layout).should be_true
end
