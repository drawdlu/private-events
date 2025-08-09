class EventsController < ApplicationController
  before_action :private_event, only: [ :show ]
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to root_path, status: :see_other
  end


  private
  def event_params
    params.require(:event).permit(:location, :date, :private)
  end

  def private_event
    @event = Event.find(params[:id])
    unless @event.invited_attendees.include?(current_user) || @event.private == false
      flash[:notice] = "Only invited guests may view this event"
      redirect_to root_path
    end
  end
end
