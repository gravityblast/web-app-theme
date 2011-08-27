Feature: Layout generation
  In order to create a great application
  I should be able to generate a layout with Web App Theme
  
  # script/generate theme
  Scenario: Generate a layout    
    Given I have a new rails app
    And   I have no layouts
    And   I have no stylesheets
    When  I generate a theme
    Then  I should have a layout named "application.html.erb"
    And   I should have a stylesheet named "web_app_theme.css"
    And   The stylesheet "web_app_theme.css" should contain "web-app-theme/themes/default/"
  
  # script/generate theme admin
  Scenario: Generate a layout with a name
    Given I have a new rails app
    And   I have no layouts
    And   I generate a theme with name "admin"
    Then  I should have a layout named "admin.html.erb"
    And   I should have a stylesheet named "web_app_theme.css"
    And   The stylesheet "web_app_theme.css" should contain "web-app-theme/themes/default/"
  
  # script/generate theme --theme="drastic-dark"
  Scenario: Generate a layout choosing a theme
    Given I have a new rails app
    And I have no stylesheets
    And I generate a theme choosing the "drastic-dark" theme
    Then The stylesheet "web_app_theme.css" should contain "web-app-theme/themes/drastic-dark/"
  
  # script/generate theme --theme=bec --no_layout
  Scenario: Generate only stylesheets without layout
    Given I have a new rails app
    And I have no layouts
    And I generate a theme without layout choosing the "bec" theme
    Then The stylesheet "web_app_theme.css" should contain "web-app-theme/themes/bec/"
    But I should not have any layouts
  
  # script/generate theme --app_name="My New Application"
  Scenario: Generate layout with application name
    Given I have a new rails app
    And I have no layouts
    And I generate a theme with application name "My New Application"
    Then The layout "application.html.erb" should contain "My New Application"
  
  # script/generate theme --type=sign
  Scenario: Generate layout for signin and signup
    Given I have a new rails app
    And I have no layouts
    And I generate a theme for signin and signup
    Then I should have a layout named "sign.html.erb"
    And I should have a layout named "sign.html.erb"
