class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @events = User.find(params[:id]).events
  end
end
