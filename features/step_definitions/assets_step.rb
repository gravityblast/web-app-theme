Given /^I generate assets$/ do
  steps %Q{
    And I run `rails generate web_app_theme:assets`
    And I wait "5" seconds
  }
end

Given /^I generate assets choosing the "([^\"]*)" theme$/ do |theme_name|
  steps %Q{
    And I run `rails generate web_app_theme:assets --theme=#{theme_name}`
    And I wait "5" seconds
  }
end
