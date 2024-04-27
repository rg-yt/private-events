class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :find_event, only: %i[create destroy]
  def create
    if current_user.attended_events << @event
      redirect_to event_path(@event.id), notice: "You've joined #{@event.title}"
    else
      flash[:notice] = "Cannot find event #{params}"
      redirect_to root_path
    end
  end

  def destroy
    if current_user.attended_events.delete(@event)
      redirect_to event_path(@event.id), notice: "You\'re no longer attending #{@event.title}"
    else
      flash[:notice] = 'Unable to delete event'
    end
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
