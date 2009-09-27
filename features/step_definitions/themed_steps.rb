Given /^a model "([^\"]*)"$/ do |model_name|
  generate_model(model_name)  
end

Given /^I generate views for controller "([^\"]*)"$/ do |controller_path|
  generate_views(controller_path)
end

When /^I generate views for controller "([^\"]*)" and model "([^\"]*)"$/ do |controller_path, model_name|
  generate_views(controller_path, model_name)
end

When /^I generate text views for "([^\"]*)"/ do |controller_path|
  generate_views(controller_path, :themed_type => :text)
end

Then /^I should have a view named "([^\"]*)"$/ do |view_path|
  view_exists?(view_path).should be_true
end