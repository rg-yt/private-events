class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @events = current_user.created_events
    @joined_events = current_user.attended_events
  end
end
