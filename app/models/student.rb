class Student < ApplicationRecord
  belongs_to :user
  belongs_to :study_room
  has_one :wallet

  after_create :create_wallet!

  delegate :name, to: :user
end
