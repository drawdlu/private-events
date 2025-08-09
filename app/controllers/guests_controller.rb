class GuestsController < ApplicationController
  def new
    @event = Event.find(guest_params["event_id"])
    @users = User.all
    @guest = Guest.new
  end
  def create
    @access = guest_params["access"]

    if @access == "attending"
      @guest = current_user.guests.build(guest_params)
    else

      @user = User.find(guest_params["user_id"])
      @guest = @user.guests.build(guest_params)
    end

    if @guest.save
      if @access == "attending"
        flash[:notice] = "You have successfully signed up for the event"
        redirect_to root_path
      else
        @event = Event.find(@guest.event_id)
        @users = User.all
        redirect_to new_guest_path
      end
    else
      render "events/show", locals: { event: @event }, status: :unprocessable_entity
    end
  end

  def destroy
    if guest_params["access"] == "attending"
      @guest = current_user.guests.find_by(guest_params)
      @guest.destroy

      flash[:notice] = "Successfully unattended event"
      redirect_to root_path status: :see_other
    else
      @guest = Guest.find_by(guest_params)
      @guest.destroy

      redirect_to new_guest_path
    end
  end

  private

  def guest_params
    params.permit(:event_id, :access, :user_id)
  end
end
