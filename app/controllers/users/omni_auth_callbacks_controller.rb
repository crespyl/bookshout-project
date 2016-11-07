class Users::OmniAuthCallbacksController < Devise::OmniauthCallbacksController

  # Incoming calls to the oauth callback will not have the csrf tokens,
  # so we need to skip the check
  skip_before_action :verify_authenticity_token, :only => [:developer, :github]

  def developer
    create_session(request.env["omniauth.auth"])
  end

  def github
    raise request.env["omniauth.auth"].inspect
    create_session(request.env["omniauth.auth"])
  end

  def failure
    raise "omniauth failed"
  end

  private

  def create_session(auth_hash)
    @user = User.find_or_initialize_by(name: auth_hash.info.name)
    @user.name = auth_hash.info.name
    @user.email = auth_hash.info.email
    @user.save
    session[:user_id] = @user.id

    redirect_to '/'
  end
end
