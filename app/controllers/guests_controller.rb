class GuestsController < ApplicationController
  def create
    @event = Event.find(guest_params["event_id"])

    if own_event
      flash.now[:notice] = "You created this event"
      render "events/show", locals: { event: @event }, status: :method_not_allowed
    else
      @guest = current_user.guests.build(guest_params)

      begin
        if @guest.save
          redirect_to root_path
        else
          render "events/show", locals: { event: @event }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotUnique
          flash.now[:notice] = "You have already signed up for this event"
          render "events/show", locals: { event: @event }, status: :unprocessable_entity
      end
    end
  end

  private

  def guest_params
    params.permit(:event_id)
  end

  def own_event
    @creator_id = @event.creator.id
    current_user.id == @creator_id
  end
end
