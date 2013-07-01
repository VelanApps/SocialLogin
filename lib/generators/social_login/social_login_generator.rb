require 'devise'
require 'omniauth'
require 'omniauth-twitter'
require 'omniauth-facebook'
require 'omniauth-linkedin'
require 'rails/generators'
require 'rails/generators/migration'

#class for Social Login Generator
class SocialLoginGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  #defining function to source_root
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end # EO def self.source_root

  #defining function to next migration number
  def self.next_migration_number(dirname)
    unless @prev_migration_nr
      @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i 
    else
      @prev_migration_nr += 1
    end #EO @prev_migration_nr
    @prev_migration_nr.to_s
  end  #EO self.next_migration_number

  #defining function to installation for devise
  def install_devise
    require 'devise'
    if File.exists?(File.join(destination_root, "config", "initializers", "devise.rb"))
        puts "\n=================================================================================\n"
        puts "No need to install devise, already done."
         if File.exists?(File.join(destination_root, "app", "models", "user.rb"))
           puts "No need to generate a user model for devise,already done."
             application  do
               "config.devise_model_name = 'user'"
             end #EO application while
         else
            model_name = ask("What is the devise model to be called? [user]")
            generate("devise", model_name)
              application do
                "config.devise_model_name = '"+model_name.to_s+"'"
              end  #EO application while 
         end #EO File exists user.rb if
        puts "\n================================================================================\n"
    else
         if yes?("Would you like to install Devise?")
            gem("devise")
            generate("devise:install")
            model_name = ask("What would you like the user model to be called? [user]")
            model_name = "user" if model_name.blank?
            generate("devise", model_name)
             application do
                "config.devise_model_name = '"+model_name.to_s+"'"
              end #EO application while
           puts "\n===============================================================================\n"   
         end #EO Devise install if 
    end #EO File exists devise.rb if
  end #EO def install_devise
  
  #defining function add_values_application_controller
  def add_values_application_controller
      inject_into_class "app/controllers/application_controller.rb", "ApplicationController" do
          " helper_method :current_user \n " +
          "  private \n" +
          "  def current_user \n" +
          "    table_name = Rails.application.config.devise_model_name.titlecase \n"+
          "    @table_name = table_name.constantize \n"+
          "    @current_user ||= @table_name.find(session[:user_id]) if session[:user_id] \n\n" +
          "  end \n\n" +
          "  def after_sign_in_path_for(current_user) \n"+
          "    table_name = Rails.application.config.devise_model_name.titlecase \n"+
          "    @table_name = table_name.constantize\n"+
          "    @user = @table_name.find_by_id(current_user) \n " +
          "    @socialAccounts = SocialAccount.find_by_user_id(@user.id.to_s) \n\n"+
          "    if @user \n"+
          "      if @socialAccounts \n "+
          "         session[:user_id] = @user.id \n"+
          "         sign_in(@user) \n"+
          "         return root_path \n"+
          "      else \n"+
          "         @newaccount = SocialAccount.new \n"+
          "         @newaccount.user_id = @user.id \n"+
          "         @newaccount.provider = session[:auth_provider] \n"+
          "         @newaccount.uid = session[:auth_uid] \n"+
          "         @newaccount.account_name = session[:auth_account_name] \n"+
          "         @newaccount.save! \n"+
          "         session[:user_id] = @user.id \n"+
          "         sign_in(@user) \n"+
          "         return root_path \n"+
          "      end \n"+
          "   else \n"+
          "      session[:auth_provider] =nil \n"+
          "      session[:auth_uid] =nil \n"+
          "      session[:auth_account_name]=nil \n"+
          "      session[:user_id] = nil \n"+
          "      flash[:notice] = 'Not yet registered' \n"+
          "      return root_path \n"+
          "   end \n"+
          "   end \n\n"
      end #EO inject_into_class
 end #EO add_values_application_controller
  
  #defining function to add values in routes.rb file 
  def add_devise_routes
    puts "\n==============================================================================================\n"
    puts " Kindly place the routes in routes.rb file\n"
    puts " match '/auth/:provider/callback', :to => 'sessions#create' \n"
    puts " match '/signout', :to => 'sessions#destroy' , :as => :signout \n"
    puts "\n==============================================================================================\n"
  end #EO def add_devise_routes
  
  #defining function to migrate the migration file for social accounts
  def create_migration_file
    sleep 1
    migration_template 'migration.rb', 'db/migrate/create_social_accounts.rb'
    copy_file "social_account.rb", "app/models/social_account.rb"
  end #EO def create_migration_file
  
  #defining function to create omniatuh intializer file
  def create_ominiauth_intializer_file
   copy_file "omniauth.rb", "config/initializers/omniauth.rb"
  end #EO def create_ominiauth_intializer_file
  
  #defining function to create sessions controller file
  def create_controller_file
    copy_file "sessions_controller.rb", "app/controllers/sessions_controller.rb"
  end #EO def create_controller_file
  
  #defining function to create sessions view file
  def create_view_file
    puts "\n===========================================================================\n"
    puts " Kindly place the code in the html file you need to create the social login \n"
    puts "<%= render 'sessions/social_login' %>"
    puts "\n============================================================================\n"
    copy_file "_social_login.html.erb", "app/views/sessions/_social_login.html.erb"
  end #EO def create_view_file
  
  #defining function to create images file
  def create_images_file
    copy_file "twitter_64.png", "app/assets/images/twitter_64.png"
    copy_file "facebook_64.png", "app/assets/images/facebook_64.png"
    copy_file "linkedin_64.png", "app/assets/images/linkedin_64.png"
  end #EO def create_images_file
  
  #defining function to create yml file
  def create_yml_file
    puts "\n======================================================================================\n"
    puts " Kindly Replace the Consumer Key and Consumer Secret of your App in the .yml files"
    puts "\n======================================================================================\n"
    copy_file "twitter.yml", "config/twitter.yml"
    copy_file "facebook.yml", "config/facebook.yml"
    copy_file "linkedin.yml", "config/linkedin.yml"
  end #EO def create_yml_file
end #EO class for Social Login Generator