Given /^I generate a theme$/ do
  steps %Q{
    And I run `rails g web_app_theme:theme`
  }
end

Given /^I generate a theme with name "(.*)"$/ do |name|
  steps %Q{
    And I run `rails g web_app_theme:theme #{name}`
  }
end

Given /^I generate a theme choosing the "(.*)" theme$/ do |theme_name|
  steps %Q{
    And I run `rails g web_app_theme:theme --theme=#{theme_name}`
  }
end

Given /^I generate a theme without layout choosing the "(.*)" theme$/ do |theme_name|
  steps %Q{
    And I run `rails g web_app_theme:theme --theme=#{theme_name} --no_layout`
  }
end

Given /^I generate a theme with application name "(.*)"$/ do |app_name|
  steps %Q{
    And I run `rails g web_app_theme:theme --app_name=#{app_name}`
  }
end

Given /^I generate a theme for signin and signup$/ do
  steps %Q{
    And I run `rails g web_app_theme:theme --layout_type=sign`
  }
end
