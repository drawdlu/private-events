class UsersController < ApplicationController
  def show
    @events = User.events
  end
end
