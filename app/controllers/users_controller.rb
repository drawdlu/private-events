class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :view_own_page_only, only: [ :show ]
  def show
    @events = User.find(params[:id]).events
  end

  private

  def view_own_page_only
    @user = User.find(params[:id])

    if current_user != @user
      flash[:notice] = "You can only view your own user page"
      redirect_to root_path
    end
  end
end
