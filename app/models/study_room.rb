class StudyRoom < ApplicationRecord
  belongs_to :classroom_teacher, class_name: 'User', optional: true

  has_many :students
  has_many :teachers
  has_many :invites

  validates :title, presence: true
end
