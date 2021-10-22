class EventsController < ApplicationController
  before_action :set_event, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events or /events.json
  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event
      flash[:notice] = "Event was successfully created."
    else
      render :new
    end
  end

  def attend
    if event_own?
      flash[:alert] = "Creator(you) can't be attendee on own event!"
    elsif current_user.attended_event_ids.include?(@event.id)
      flash[:alert] = "You already attendee of this event!"
    else
      @event.attendees << current_user
      flash[:notice] = "Successfully add #{current_user.name} as attendee of #{@event.title} event."
    end
    redirect_to @event
  end

  def leave
    if event_own?
      flash[:alert] = "As event creator, you can't leave. If you want, you can destroy this event."
    elsif !current_user.attended_event_ids.include?(@event.id)
      flash[:alert] = "You not attendee of this event!"
    else
      @event.attendees.destroy(current_user)
      flash[:notice] = "Successfully leave from #{@event.title} event."
    end
    redirect_to @event
  end

  def edit
    unless event_own?
      flash[:alert] = "You can't edit not own event!"
      redirect_to @event
    end
  end

  def update
    if event_own?
      if @event.update(event_params)
        redirect_to @event
        flash[:notice] = "Event was successfully updated."
      else
        render :edit
      end
    else
      flash[:alert] = "You can't edit not own event!"
      redirect_to @event
    end
  end

  def destroy
    if event_own?
      @event.destroy
      flash[:notice] = "Event was successfully destroyed."
      redirect_to events_path
    else
      flash[:alert] = "You can't edit not own event!"
      redirect_to @event
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:date, :title, :description)
  end

  def event_own?
    @event.creator_id == current_user.id
  end
end
