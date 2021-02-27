class Teacher < ApplicationRecord
  belongs_to :user
  belongs_to :study_room
end
