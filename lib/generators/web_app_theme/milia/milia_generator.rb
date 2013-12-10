module WebAppTheme
  class MiliaGenerator < Rails::Generators::Base
# *************************************************************
    desc "Installs milia-specific hooks"
    source_root File.expand_path('../templates', __FILE__)
    argument :project_name, :type => :string, :default => 'Simple Milia App'
     
# *************************************************************

    def check_prerequisites
      find_or_fail( "app/models/tenant.rb" )
      find_or_fail( "app/models/member.rb" )
      find_or_fail( "app/controllers/members_controller.rb" )
    end

    def milia_hooks

      generate 'web_app_theme:theme' "--engine=haml --theme='red' --app-name='#{project_name}'"
      generate 'web_app_theme:themed' 'home --themed-type=text --theme="red" --engine=haml'
      generate 'web_app_theme:theme' "sign --layout-type=sign --theme='red' --engine=haml --app-name='#{project_name}'"

      inside('app/views/layouts') do
        run('rm application.html.erb')
      end

      inside('app/views/home') do
        run('mv show.html.haml index.html.haml')
      end

      uncomment_lines "config/initializers/devise.rb", /pepper|confirmation_keys|email_regexp/
      uncomment_lines "config/application.rb", 'config.time_zone'

      environment  do
        snippet_config_precompile
      end  # do config/app.rb

  
# uncomment the config.time_zone line and set it to your timezone
    config.time_zone = 'Pacific Time (US & Canada)'

    prepend_to_file 'app/views/members/new.html.haml', "%h1 <projectname>"

# EDIT app/controllers/application_controller.rb
# ADD:
  snippet_app_ctlr_prep_org_name
# EDIT app/views/layouts/application.rb >>>>>>>>>>>>>>>>>>>>
# "= @org_name", make the results look like the two lines below

  %title= @org_name

  = link_to @org_name, "/"

# make changes to layout for invite member; change the portion 
# with the "sign_up" link to look like the following:
  snippet_layout_invite_member

# UNCOMMENT after the class line: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  layout  "sign", :only => [:new, :edit, :create]






    end
# *************************************************************
# *************************************************************

  protected
   
# *************************************************************
# *************************************************************
    def snippet_config_precompile
    <<-'RUBY30'
      #  For faster asset precompiles, you can partially load your application. 
      #  In that case, templates cannot see application objects or methods. 
      #  Heroku requires this to be false.
      config.assets.initialize_on_precompile = false
    RUBY30
    end

    def snippet_app_ctlr_prep_org_name
    <<-'RUBY31'
  before_action  :prep_org_name

  private

  # org_name will be passed to layout & view
  def prep_org_name()
    @org_name = ( user_signed_in?  ?
      Tenant.current_tenant.name  :
      "#{project_name}"
    )

  end
    RUBY31
    end

  def snippet_layout_invite_member
  <<-'RUBY32'
            %li
              - if user_signed_in?
                = link_to t("web-app-theme.invite", :default => "Invite member"), new_member_path
              - else
                = link_to( t("web-app-theme.signup", :default => "Sign up"), new_user_registration_path )

  RUBY32
  end

    def snippet_spare1
    <<-'RUBY33'
    RUBY33
    end

    def snippet_spare2
    <<-'RUBY34'
    RUBY34
    end
  
# *************************************************************
# *************************************************************
    def generate_haml_layout(admin_layout_name)
      require 'haml'
      Dir.mktmpdir('web-app-theme-haml') do |haml_root|
        tmp_html_path = "#{haml_root}/#{admin_layout_name}"
        tmp_haml_path = "#{haml_root}/#{admin_layout_name}.haml"
        template admin_layout_name, tmp_html_path, :verbose => false
        `html2haml --erb #{tmp_html_path} #{tmp_haml_path}`
        copy_file tmp_haml_path, "app/views/layouts/#{layout_name.underscore}.html.haml"
      end
    rescue LoadError
      say "HAML is not installed, or it is not specified in your Gemfile."
      exit
    end

# -------------------------------------------------------------
# -------------------------------------------------------------
  def find_or_fail( filename )
    user_file = Dir.glob(filename).first
    if user_file.blank? 
      alert_color = :red
      say("-------------------------------------------------------------------------", alert_color)
      say_status("error", "file: '#{filename}' not found", alert_color)
      say("-   first run  $ rails g milia:install", alert_color)
      say("-   then retry $ rails g web_app_theme:milia", alert_color)
      say("-------------------------------------------------------------------------", alert_color)
 
      raise Thor::Error, "************  terminating generator due to file error!  *************" 
    end
    return user_file
  end
 
# *************************************************************

  end
end
