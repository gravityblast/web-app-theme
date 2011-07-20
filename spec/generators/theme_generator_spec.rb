require '../spec_helper'
require "generators/web_app_theme/theme/theme_generator"
require 'generator_spec/test_case'

describe WebAppTheme::ThemeGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path("../../tmp", __FILE__)

  context "with no arguments" do
    before(:all) do
      prepare_destination
      run_generator
    end

    it "creates the default admin layout" do
      assert_file "app/views/layouts/application.html.erb", /web-app-theme/
    end

    specify do
      destination_root.should have_structure {
        no_file "test.rb"
        directory "app" do
          directory "views" do
            directory "layouts" do
              file "application.html.erb" do
                contains "web-app-theme"
              end
            end
          end
        end
        directory "public" do
          directory "images" do
            directory "web-app-theme" do
              file "avatar.png"
              directory "icons" do
                file "application_edit.png"
                file "cross.png"
                file "key.png"
                file "tick.png"
              end
            end
          end
          directory "stylesheets" do
            directory "web-app-theme" do
              file "base.css"
              file "override.css"
              directory "themes" do
                directory "default" do
                  file "style.css"
                  directory "images" do
                    file "arrow.png"
                    file "boxbar-background.png"
                    file "boxbar-background-active.png"
                    file "button-background.png"
                    file "menubar-background.png"
                  end
                end
              end
            end
          end
        end
      }
    end


  end


end
