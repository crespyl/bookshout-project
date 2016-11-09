class SearchController < ApplicationController
  def index
    # if logged in, load the current user
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
    end

    # if we have a github token, set up the OctoKit client to use it, otherwise
    # authenticate with our client id/secret
    if session[:github_token]
      @github = Octokit::Client.new(:access_token => session[:github_token])
      @github_user = @github.user
    else
      @github = Octokit::Client.new(:client_id => ENV['GITHUB_CLIENT_ID'],
                                    :client_secret => ENV['GITHUB_CLIENT_SECRET'])
    end

    # search query, if present
    @query = params[:query] || ''
    @page = (params[:page] || 1).to_i
    @per_page = (params[:per_page] || 100).to_i

    if @query != ''
      @results = get_search_results(@query, @page, @per_page)
      # GitHub only provides the first 1000 results, so we'll cap there
      @num_pages = [@results.total_count, 1000].min() / @per_page
    end
  end

  private

  def get_search_results(query, page=0, per_page=100)
    return @github.search_repositories query, {:page => page,
                                               :per_page => per_page}
  end
end
