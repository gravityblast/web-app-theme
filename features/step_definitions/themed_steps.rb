Given /^I run the themed generator for the "([^\"]*)" controller$/ do |controller_name|
  steps %Q{
    And I run `rails g web_app_theme:themed #{controller_name}`
  }
end

When /I run the themed generator for the "([^\"]*)" controller with the model "([^\"]*)"/ do |controller_name, model_name|
  steps %Q{
    And I run `rails g web_app_theme:themed #{controller_name} #{model_name}`
  }
end

Given /^I run the themed generator for the "([^\"]*)" controller with the option --"([^\"]*)"="([^\"]*)"$/ do |controller_name, option, value|
  steps %Q{
    And I run `rails g web_app_theme:themed #{controller_name} --#{option}=#{value}`
  }
end
