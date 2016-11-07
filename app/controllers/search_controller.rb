class SearchController < ApplicationController
  def index
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
    elsif Rails.env.developer?
      redirect_to user_developer_authorize_url
    else
      # redirect_to user_github_omniauth_authorize_url
    end
  end
end
