class SessionController < ApplicationController

  # Redirect to appropriate login process
  def login
    if Rails.env.production?
      redirect_to user_github_omniauth_authorize_url
    elsif Rails.env.development?
      redirect_to user_developer_omniauth_authorize_url
    end
  end

  # Clear the current session
  def logout
    session.delete(:user_id)
    redirect_to '/'
  end
end
