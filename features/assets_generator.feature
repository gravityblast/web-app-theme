Feature: Layout generation
  In order to customize my great application layout
  I should be able to copy web-app-theme default's styles to my application assets path 
  
  # script/generate theme
  Scenario: Generate assets
    Given I have a new rails app
    When I generate assets 
    Then I should have a stylesheet named "web-app-theme/base.css"
    And  I should have a stylesheet named "web-app-theme/themes/default/style.css"

  # script/generate theme
  Scenario: Generate assets with --theme=red
    Given I have a new rails app
    And I have no stylesheets
    When I generate assets choosing the "red" theme 
    Then I should have a stylesheet named "web-app-theme/base.css"
    And  I should have a stylesheet named "web-app-theme/themes/red/style.css"
