class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :study_room

  scope :teachers, -> { where is_teacher: true }
  scope :students, -> { where is_student: true }
  scope :leads, -> { where is_lead: true }

  delegate :full_name, to: :user
end
