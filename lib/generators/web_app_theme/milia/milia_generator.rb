module WebAppTheme
  class MiliaGenerator < Rails::Generators::Base
# *************************************************************
    desc "Installs milia-specific hooks"
    
    source_root File.expand_path('../templates', __FILE__)

    argument :project_name, :type => :string, :default => 'Simple Milia App'

    class_option :timezone, :type => :string, :default => 'Pacific Time (US & Canada)', :desc => 'Specify the app timezone in standard Rails format'
     
# *************************************************************

    def check_prerequisites
      file_find_or_fail( "app/models/tenant.rb" )
      file_find_or_fail( "app/models/member.rb" )
      file_find_or_fail( "app/controllers/members_controller.rb" )
             
      gem_find_or_fail(
        [
          %w(Milia, milia),
          %w(Devise, devise),
          %w(Haml, haml),
          %w(Html2haml, html2haml),
        ]
      )

    end

    def milia_hooks

      generate 'web_app_theme:theme',  "--engine=haml --theme='red' --app-name='#{project_name}'"
      generate 'web_app_theme:themed', 'home --themed-type=text --theme="red" --engine=haml'
      generate 'web_app_theme:theme',  "sign --layout-type=sign --theme='red' --engine=haml --app-name='#{project_name}'"
      generate 'web_app_theme:devise'

      inside('app/views/layouts') do
        run('rm application.html.erb')
      end

      inside('app/views/home') do
        run('mv show.html.haml index.html.haml')
      end

      inside('app/assets/stylesheets') do
        run('mv web-app-theme/error_styles.sass .')
      end

      uncomment_lines "config/initializers/devise.rb", /config\.(pepper|confirmation_keys|email_regexp)/

      uncomment_lines "config/application.rb", 'config.time_zone'
      gsub_file 'config/application.rb', /Central Time \(US & Canada\)/, "#{options.timezone}"

      uncomment_lines  "config/application.rb", 'Devise'

      environment  do
        snippet_config_precompile
      end  # do config/app.rb

      prepend_to_file 'app/views/members/new.html.haml', "%h1= @org_name\n"

      inject_into_file "app/controllers/application_controller.rb",
       after: ":invalid_tenant\n" do 
       snippet_app_ctlr_prep_org_name
      end

      inject_into_file "app/controllers/home_controller.rb",
       after: "def index\n" do 
       snippet_replace_index
      end

      inject_into_file "app/controllers/home_controller.rb",
       after: ":only => [ :index ]\n" do 
       snippet_add_welcome
      end

      inside('app/views/home') do
        run('cp index.html.haml welcome.html.haml')
      end

      gsub_file 'app/views/home/welcome.html.haml',' Home', '= @org_name'

      route 'get "home/welcome", :as => :welcome'

      gsub_file 'app/views/layouts/application.html.haml', "#{project_name}", '@org_name'
      gsub_file 'app/views/layouts/application.html.haml', '$@org_name$', "#{project_name}"
      gsub_file 'app/views/layouts/application.html.haml', '"@org_name"', '@org_name'
      gsub_file 'app/views/layouts/application.html.haml', "%title", '%title='

      uncomment_lines 'app/controllers/members_controller.rb', 'layout  "sign"'

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
    <<RUBY31
  before_action  :prep_org_name

  private

  #   org_name will be passed to layout & view
  def prep_org_name()
    @org_name = ( user_signed_in?  ?
      Tenant.current_tenant.name  :
      \"#{project_name}\"
    )

  end
RUBY31
    end

    def snippet_replace_index
    <<-'RUBY33'
    if user_signed_in?

        # was there a previous error msg carry over? make sure it shows in flasher
      flash[:notice] = flash[:error] unless flash[:error].blank?
      redirect_to(  welcome_path()  )

    else

      if flash[:notice].blank?
        flash[:notice] = "sign in if your organization has an account"
      end

    end   # if logged in .. else first time

    RUBY33
    end

    def snippet_add_welcome
    <<-'RUBY34'

    def welcome
    end

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
  def gem_find_or_fail( list )
    need_fail = false
    alert_color = :red
    list.each do |const, gem_name|
      unless WebAppTheme.const_defined?( const )
        say_status("error", 
            "class: '#{const}' not found; gemfile: #{gem_name} is required", 
            alert_color)
        need_fail = true
      end # unless missing
    end # each constant to be checked

    if need_fail
      say("-------------------------------------------------------------------------", alert_color)
      say("-   add required gems to Gemfile; then run bundle install", alert_color)
      say("-   then retry rails g milia:install", alert_color)
      say("-------------------------------------------------------------------------", alert_color)
      raise Thor::Error, "************  terminating generator due to missing requirements!  *************" 
    end  # need to fail
    
  end
 

# -------------------------------------------------------------
# -------------------------------------------------------------
  def file_find_or_fail( filename )
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
