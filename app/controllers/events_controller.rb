class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create update destroy]
  before_action :find_event, only: %i[edit show destroy]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    event = current_user.created_events.build(event_params)
    if event.save
      redirect_to root_path, notice: 'You\'ve created an event!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def destroy
    if current_user == @event.creator
      current_user.created_events.destroy(@event)
      redirect_to root_path, notice: "You've deleted this event"
    else
      redirect_to event_path(event[:id]), notice: 'You cannot delete this event'
    end
  end

  def edit
    return if current_user == @event.creator

    redirect_to root_path, notice: 'You are not the creator of the event you\'re trying to edit'
  end

  def update
    event = Event.find(params[:id])
    if current_user == event.creator
      event.update(event_params)
      redirect_to root_path, notice: 'You\'ve updated your event'
    else
      redirect_to root_path, notice: 'You cannot update this event'
    end
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:date, :title)
  end
end
