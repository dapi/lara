class Wallet < ApplicationRecord
  STAR = '⭐️'

  belongs_to :student
end
