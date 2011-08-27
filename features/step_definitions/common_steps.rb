Given /^I have a new rails app$/ do
  random = Random.rand(20)
  steps %Q{
    Given I run `rails new test_app#{random}`
    And I cd to "test_app#{random}"
    And a file named "Gemfile" with:
    """
      source 'http://rubygems.org'
      gem 'rails', '3.1.0.rc6'
      gem 'web-app-theme', :path => '../../../'
    """
    And I run `bundle install`
  }
end

Then /^I should have a stylesheet named "([^"]*)"$/ do |css_file_name|
  steps %Q{
    When I run `ls -R app/assets/stylesheets`
    Then the output should contain "#{css_file_name}"
  }
end

Then /^I should have an image named "([^"]*)"$/ do |image_name|
  steps %Q{
    When I run `ls -R app/assets/images`
    Then the output should contain "#{image_name}"
  }
end

Then /^I should have a view named "([^"]*)"$/ do |view_name|
  steps %Q{
    When I run `ls -R app/views`
    Then the output should contain "#{view_name}"
  }
end

Then /^I should have a layout named "([^"]*)"$/ do |layout_name|
  steps %Q{
    When I run `ls -R app/views/layouts`
    Then the output should contain "#{layout_name}"
  }
end

Given /^I have no stylesheets$/ do
  steps %Q{
    And I run `rm -r app/assets/stylesheets/*`
  }
end

Given /^I have no layouts$/ do
  steps %Q{
    And I run `rm -r app/views/layouts/*`
  }
end

Given /^I have a model named "([^"]*)"$/ do |model_name|
  steps %Q{
    Given I run `rails g model #{model_name}`
    Given I run `bundle exec rake db:migrate RAILS_ENV=test`
  }
end

Then /^The stylesheet "([^"]*)" should contain "([^"]*)"$/ do |css_file, patern|
  steps %Q{
    When I run `cat app/assets/stylesheets/#{css_file}`
    Then the output should contain "#{patern}"
  }
end

Then /^The layout "([^"]*)" should contain "([^"]*)"$/ do |layout_file, patern|
  steps %Q{
    When I run `cat app/views/layouts/#{layout_file}`
    Then the output should contain "#{patern}"
  }
end

Then /^I should not have any layouts$/ do
  steps %Q{
    Then the file "application.html.erb" should not exist
    Then the file "application.html.haml" should not exist
  }
end
