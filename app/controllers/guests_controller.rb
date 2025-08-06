class GuestsController < ApplicationController
  def create
    @guest = current_user.guests.build(guest_params)

    if @guest.save
      redirect_to root_path
    else
      render event_path(Event.find(params[:id]))
    end
  end

  private

  def guest_params
    params.permit(:event_id)
  end
end
