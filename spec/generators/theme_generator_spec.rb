require 'spec_helper'
require 'action_controller'
require 'generator_spec/test_case'
require "generators/web_app_theme/theme/theme_generator"

describe WebAppTheme::ThemeGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path("../../tmp", __FILE__)

  context "in rails 3.0" do

    context "with no arguments" do
      before(:all) do
        #Rails.stub(:version) { '3.0.8' }
        prepare_destination
        run_generator
      end

      it "stubs the version correctly" do
        Rails.version[0..2].should == "3.0"
      end

      it "stubs the version correctly" do
        test_version = (Rails.version[0..2].to_f >= 3.1)
        test_version.should be_false
      end

      context "creates the default admin layout" do
        it "with correct stylesheet" do
          assert_file "app/views/layouts/application.html.erb", /stylesheet_link_tag "web-app-theme\/base",/
        end

        it "and correct javascript" do
          assert_file "app/views/layouts/application.html.erb", /javascript_include_tag :defaults, :cache => true/
        end
      end

      specify do
        destination_root.should have_structure {
          no_file "test.rb"
          directory "app" do
            directory "views" do
              directory "layouts" do
                file "application.html.erb" do
                  contains "web-app-theme"
                  contains 'stylesheet_link_tag "web-app-theme/base"'
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
                      file "bgd.jpg"
                      file "boxbar-background.png"
                      file "button-background-active.png"
                      file "button-background.png"
                    end
                    directory "fonts" do
                      file 'museo700-regular-webfont.eot'
                      file 'museo700-regular-webfont.svg'
                      file 'museosans_500-webfont.svg'
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

  context "in rails 3.1" do
    before(:all) do
      ::Rails.stub(:version) { '3.1.0' }
      prepare_destination
      run_generator
    end

    context "creates the default admin layout" do
      it "with correct stylesheet" do
        assert_file "app/views/layouts/application.html.erb", /stylesheet_link_tag :application/
      end

      it "and correct javascript" do
        assert_file "app/views/layouts/application.html.erb", /javascript_include_tag :application/
      end
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
        directory "app" do
          directory "assets" do
            directory "images" do
              directory "images" do
                file "arrow.png"
                file "bgd.jpg"
                file "boxbar-background.png"
                file "button-background-active.png"
                file "button-background.png"
              end
              directory "fonts" do
                file 'museo700-regular-webfont.eot'
                file 'museo700-regular-webfont.svg'
                file 'museosans_500-webfont.svg'
              end

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
