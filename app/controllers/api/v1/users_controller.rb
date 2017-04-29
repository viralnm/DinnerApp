module Api
	module V1 
		class UsersController < Api::BaseController
		  skip_before_filter :authenticate_user!, :only => [:create]
		  # before_filter :authenticate_on_create, :only => [:create]
		  skip_before_action :verify_authenticity_token, :only => [:create]
			def create
				if params[:user][:register_via] == "Manual"
					@email = User.where(email: params[:user][:email], register_via: "Manual")
					if @email.blank?
						@user = User.create(user_params)
							if @user.save
								Opro::Oauth::ClientApp.create_with_user_and_name(@user, @user.first_name+ @user.id.to_s + "DinnerApp")
								@token = Opro::Oauth::AuthGrant.where(devise_token: params[:user][:devise_token])
						    if !@token.blank?
						      @token.destroy_all
						    end
						    application = Opro::Oauth::ClientApp.where(user_id: @user.id).first
						    auth_grant = Opro::Oauth::AuthGrant.find_or_create_by_user_app(@user, application, params[:user][:devise_token], params[:devise_type])
						    render :json => { action: 'login',
	                            response: 'true',
	                            msg: 'Successfully login',
	                            access_token:  auth_grant.access_token,
	                            # http://tools.ietf.org/html/rfc6749#section-5.1
	                            token_type:    Opro.token_type || 'bearer',
	                            refresh_token: auth_grant.refresh_token,
	                            expires_in:    auth_grant.expires_in, 
	                            clien_id: application.app_id,
	                            client_secret: application.app_secret, userdetails:
	                           { user_id: @user.id, firstname: @user.first_name,lastname: @user.last_name,email: @user.email} }
							else 
								respond_to do |format|
									format.json { render :json => @user.errors }
								end
							end
					else	
						respond_to do |format|
							
								format.json { render :json => {action: 'user_manual_register',
	                                      response: 'false',
	                                     msg: 'email already exist in database.'} }
							
						end
					end
				elsif params[:user][:register_via] == "Facebook"
					@f_user = User.where(facebook_id: params[:user][:facebook_id], devise_token: params[:user][:devise_token]).first
					if @f_user.blank?
						@user = User.create(user_params)
						if @user.save
							Opro::Oauth::ClientApp.create_with_user_and_name(@user, @user.first_name+ @user.id.to_s + "DinnerApp")
							@token = Opro::Oauth::AuthGrant.where(devise_token: params[:user][:devise_token])
					    if !@token.blank?
					      @token.destroy_all
					    end
					    application = Opro::Oauth::ClientApp.where(user_id: @user.id).first
					    auth_grant = Opro::Oauth::AuthGrant.find_or_create_by_user_app(@user, application, params[:user][:devise_token], params[:devise_type])
					    render :json => { action: 'login',
                            response: 'true',
                            msg: 'Successfully login',
                            access_token:  auth_grant.access_token,
                            # http://tools.ietf.org/html/rfc6749#section-5.1
                            token_type:    Opro.token_type || 'bearer',
                            refresh_token: auth_grant.refresh_token,
                            expires_in:    auth_grant.expires_in, 
                            clien_id: application.app_id,
                            client_secret: application.app_secret, userdetails:
                           { user_id: @user.id, firstname: @user.first_name,lastname: @user.last_name,email: @user.email} }
					  else
					  	respond_to do |format|
						
								format.json { render :json => {action: 'login',
                                      response: 'false',
                                     msg: 'user not created.'} }
						
							end
					  end
					else
						@token = Opro::Oauth::AuthGrant.where(devise_token: params[:user][:devise_token])
				    if !@token.blank?
				      @token.destroy_all
				    end
					   application = Opro::Oauth::ClientApp.where(user_id: @f_user.id).first
					   auth_grant = Opro::Oauth::AuthGrant.find_or_create_by_user_app(@f_user, application, params[:user][:devise_token], params[:devise_type])
					   render :json => { action: 'login',
                            response: 'true',
                            msg: 'Successfully login',
                            access_token:  auth_grant.access_token,
                            # http://tools.ietf.org/html/rfc6749#section-5.1
                            token_type:    Opro.token_type || 'bearer',
                            refresh_token: auth_grant.refresh_token,
                            expires_in:    auth_grant.expires_in, 
                            clien_id: application.app_id,
                            client_secret: application.app_secret, userdetails:
                           { user_id: @f_user.id, firstname: @f_user.first_name,lastname: @f_user.last_name,email: @f_user.email} }
					end
				elsif params[:user][:register_via] == "Google"
					@f_user = User.where(google_id: params[:user][:google_id], devise_token: params[:user][:devise_token]).first
					if @f_user.blank?
						@user = User.create(user_params)
						if @user.save
							Opro::Oauth::ClientApp.create_with_user_and_name(@user, @user.first_name+ @user.id.to_s + "DinnerApp")
							@token = Opro::Oauth::AuthGrant.where(devise_token: params[:user][:devise_token])
					    if !@token.blank?
					      @token.destroy_all
					    end
					    application = Opro::Oauth::ClientApp.where(user_id: @user.id).first
					    auth_grant = Opro::Oauth::AuthGrant.find_or_create_by_user_app(@user, application, params[:user][:devise_token], params[:devise_type])
					    render :json => { action: 'login',
                            response: 'true',
                            msg: 'Successfully login',
                            access_token:  auth_grant.access_token,
                            # http://tools.ietf.org/html/rfc6749#section-5.1
                            token_type:    Opro.token_type || 'bearer',
                            refresh_token: auth_grant.refresh_token,
                            expires_in:    auth_grant.expires_in, 
                            clien_id: application.app_id,
                            client_secret: application.app_secret, userdetails:
                           { user_id: @user.id, firstname: @user.first_name,lastname: @user.last_name,email: @user.email} }
					  else
					  	respond_to do |format|
						
								format.json { render :json => {action: 'login',
                                      response: 'false',
                                     msg: 'user not created.'} }
						
							end
					  end
					else
						@token = Opro::Oauth::AuthGrant.where(devise_token: params[:user][:devise_token])
				    if !@token.blank?
				      @token.destroy_all
				    end
					   application = Opro::Oauth::ClientApp.where(user_id: @f_user.id).first
					   auth_grant = Opro::Oauth::AuthGrant.find_or_create_by_user_app(@f_user, application, params[:user][:devise_token], params[:devise_type])
					   render :json => { action: 'login',
                            response: 'true',
                            msg: 'Successfully login',
                            access_token:  auth_grant.access_token,
                            # http://tools.ietf.org/html/rfc6749#section-5.1
                            token_type:    Opro.token_type || 'bearer',
                            refresh_token: auth_grant.refresh_token,
                            expires_in:    auth_grant.expires_in, 
                            clien_id: application.app_id,
                            client_secret: application.app_secret, userdetails:
                           { user_id: @f_user.id, firstname: @f_user.first_name,lastname: @f_user.last_name,email: @f_user.email} }
					end
				else
					respond_to do |format|
						
							format.json { render :json => {action: 'user_manual_register',
                                      response: 'false',
                                     msg: 'wrong register_via type.'} }
						
					end
				end
			end	

			private

			# def authenticate_on_create
			# 	@opro_client = Opro::Oauth::ClientApp.authenticate(params[:client_id],params[:client_secret])
				
			# 	unauthorized_on_create unless @opro_client
			# end
			def user_params 
				params.require(:user).permit(:first_name,:last_name, :password, :email, :photo, :photo_file_name, :register_via, :devise_token, :google_id, :facebook_id, :photo_url)
			end

			# def json_opts
			# 	{:only => [:id, :first_name,:last_name, :email], :base_url=>request.url}
			# end

		end
	end
end
