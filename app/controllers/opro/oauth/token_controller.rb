# This controller is where clients can exchange
# codes and refresh_tokens for access_tokens

class Opro::Oauth::TokenController < OproController
  before_filter      :opro_authenticate_user!,    :except => [:create]
  skip_before_filter :verify_authenticity_token,  :only   => [:create]


  def create
    # Find the client application
    @token = Opro::Oauth::AuthGrant.where(devise_token: params[:devise_token])
    if !@token.blank?
      @token.destroy_all
    end
    @user=User.where(email: params[:email], register_via: "Manual").first
    
    if !@user.blank?
      application = Opro::Oauth::ClientApp.where(user_id: @user.id).first
      auth_grant  = auth_grant_for(application, params)
      if auth_grant.present?
        auth_grant.refresh!
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
                             { user_id: @user.id, firstname: @user.first_name,lastname: @user.last_name,email: @user.email,photo: @user.photo.url} }
      else
        if params[:password]
          render :json => { action: 'login',
                              response: 'false',
                              msg: 'wrong password',
                              error_code: '99'}
        end
        if params[:refresh_token]
          render :json => { action: 'login',
                              response: 'false',
                              msg: 'wrong refresh token',
                              error_code: '98'}
        end
      end
    else
    render :json => { action: 'login',
                        response: 'false',
                        msg: 'wrong email id',
                        error_code: '100'}
   end
  end

  private

  def auth_grant_for(application, params)
    if params[:code]
      Opro::Oauth::AuthGrant.find_by_code_app(params[:code], application)
    elsif params[:refresh_token]
      Opro::Oauth::AuthGrant.find_by_refresh_app(params[:refresh_token], application)
    elsif params[:password].present? || params[:grant_type] == "password"|| params[:grant_type] == "bearer"
      return false unless Opro.password_exchange_enabled?
      return false unless oauth_valid_password_auth?(application.app_id, application.app_secret)
      user       = ::Opro.find_user_for_all_auths!(self, params)
      return false unless user.present?
      auth_grant = Opro::Oauth::AuthGrant.find_or_create_by_user_app(user, application, params[:devise_token], params[:devise_type])
      auth_grant.update_permissions if auth_grant.present?
      auth_grant
    end
  end

  # def debug_msg(options, app)
  #   msg = "Could not find a user that belongs to this application"
  #   msg << " based on client_id=#{options[:client_id]} and client_secret=#{options[:client_secret]}" if app.blank?
  #   msg << " & has a refresh_token=#{options[:refresh_token]}" if options[:refresh_token]
  #   msg << " & has been granted a code=#{options[:code]}"      if options[:code]
  #   msg << " using username and password"                      if options[:password]
  #   msg
  # end

  # def render_error(msg)
  #   render :json => {:error => msg }, :status => :unauthorized
  # end

end
