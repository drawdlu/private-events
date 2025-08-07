class GuestsController < ApplicationController
  def create
    @guest = current_user.guests.build(guest_params)

    if @guest.save
      flash[:notice] = "You have successfully signed up for the event"
      redirect_to root_path
    else
      render "events/show", locals: { event: @event }, status: :unprocessable_entity
    end
  end

  def destroy
    @guest = current_user.guests.find_by(guest_params)
    @guest.destroy

    flash[:notice] = "Successfully unattended event"
    redirect_to root_path status: :see_other
  end

  private

  def guest_params
    params.permit(:event_id, :access)
  end
end
