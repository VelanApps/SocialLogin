class SessionsController < ApplicationController
    
        def index
          
        end
        
        def create
              auth = request.env["omniauth.auth"]
              @socialAccounts = SocialAccount.find_by_provider_and_uid(auth["provider"], auth["uid"])
              @devise_model_name = Rails.application.config.devise_model_name
              table_name = Rails.application.config.devise_model_name.titlecase
              @table_name = table_name.constantize
              @user = @table_name.find(session[:user_id]) if session[:user_id]
              if @user
                 @userAlready = SocialAccount.find_by_user_id(@user.id.to_s)
                 if @userAlready         
                     submission_hash = {
                                        "provider" => auth["provider"],
                                        "uid" => auth["uid"],
                                        "account_name" => auth["info"]["name"]}
                                            
                     @userAlready.update_attributes(submission_hash)
                     flash[:notice] = "Already Signed in!"
                     session[:user_id] = @user.id
                     redirect_to "/"
                else
                    if  @socialAccounts 
                        submission_hash = {
                                          "provider" => auth["provider"],
                                          "uid" => auth["uid"],
                                          "account_name" => auth["info"]["name"]}
                        @socialAccounts.update_attributes(submission_hash)
                        flash[:notice] = "Already Signed in!"
                        session[:user_id] = @socialAccounts.user_id
                        @user = @table_name.find(session[:user_id]) if session[:user_id]
                        sign_in(@user)
                        redirect_to "/"
                    else               
                       @newaccount = SocialAccount.new
                       @newaccount.user_id = @user.id
                       @newaccount.provider = session[:auth_provider]
                       @newaccount.uid =  session[:auth_uid]
                       @newaccount.account_name = session[:auth_account_name]
                       @newaccount.save!
                       flash[:notice] = "Signed in successfully!"
                       session[:user_id] = @user.id
                       redirect_to "/"
                    end
                end 
             else
                if  @socialAccounts
                       submission_hash = {
                                          "provider" => auth["provider"],
                                          "uid" => auth["uid"],
                                          "account_name" => auth["info"]["name"]}
                        @socialAccounts.update_attributes(submission_hash)
                       flash[:notice] = "Already Signed in!"
                       session[:user_id] = @socialAccounts.user_id
                       @user = @table_name.find(session[:user_id]) if session[:user_id]
                       sign_in(@user)
                       redirect_to "/"
               else
                   session[:auth_provider] = auth["provider"]
                   session[:auth_uid] = auth["uid"]
                   session[:auth_account_name] = auth["info"]["name"]
                   flash[:notice] = "\n This is one time process \n"
                   redirect_to "/"+@devise_model_name+"s/sign_up"
               end
             end
        end
    
        def destroy
          @devise_model_name = Rails.application.config.devise_model_name
          table_name = Rails.application.config.devise_model_name.titlecase
          @table_name = table_name.constantize
          session[:user_id] = nil
          signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(@devise_model_name))
          redirect_to "/", :notice => "Signed out!"
        end
end
