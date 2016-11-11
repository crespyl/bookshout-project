class GuestbookController < ApplicationController
  def index
    @users = User.all
  end
end
