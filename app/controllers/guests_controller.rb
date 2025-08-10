class GuestsController < ApplicationController
  def new
    @event = Event.find(guest_params["event_id"])
    @users = User.all
  end
  def create
    if guest_params["access"] == "attending"
      @guest = current_user.guests.build(guest_params)

      @guest.save

      flash[:notice] = "You have successfully signed up for the event"
      redirect_to event_path(guest_params["event_id"])
    else
      @user = User.find(guest_params["user_id"])
      @guest = @user.guests.build(guest_params)

      @guest.save

      redirect_to new_guest_path
    end
  end

  def destroy
    if guest_params["access"] == "attending"
      @guest = current_user.guests.find_by(guest_params)
      @guest.destroy

      flash[:notice] = "Successfully unattended event"
      redirect_to event_path(guest_params["event_id"])
    else
      @guests = Guest.where(event_id: guest_params["event_id"],
                          user_id: guest_params["user_id"])

      @guests.each do |guest|
        guest.destroy
      end

      redirect_to new_guest_path
    end
  end

  private

  def guest_params
    params.permit(:event_id, :access, :user_id)
  end
end
