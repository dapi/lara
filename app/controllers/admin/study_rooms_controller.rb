class Admin::StudyRoomsController < ApplicationController
  def index
    render locals: { study_rooms: StudyRoom.order(:title) }
  end
end
