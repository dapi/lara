class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :memberships
  has_many :study_rooms, through: :memberships
end
