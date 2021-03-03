class Wallet < ApplicationRecord
  STAR = '⭐️'

  has_many :wallet_transfers, dependent: :destroy

  belongs_to :student

  has_many :transfers, class_name: 'WalletTransfer'
end
