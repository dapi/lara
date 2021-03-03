class Student < ApplicationRecord
  belongs_to :user
  belongs_to :study_room

  has_one :wallet, dependent: :destroy
  has_many :wallet_transfers, through: :wallet

  after_create :create_wallet!

  delegate :name, to: :user
end
