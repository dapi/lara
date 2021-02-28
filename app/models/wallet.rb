class Wallet < ApplicationRecord
  STAR = '⭐️'

  belongs_to :student

  has_many :transfers, class_name: 'WalletTransfer'
end
