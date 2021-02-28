class WalletTransfer < ApplicationRecord
  belongs_to :wallet
  belongs_to :payer, class_name: 'User'
end
