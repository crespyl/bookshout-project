class SearchController < ApplicationController
  def index
    # if logged in, load the current user
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
    end

    # search query, if present
    @query = params[:query] || ''
    @page = params[:page] || 0

    if @query
      @results = get_search_results(@query, @page)
    end
  end

  private

  def get_search_results(query, page=0)
    return []
  end
end
