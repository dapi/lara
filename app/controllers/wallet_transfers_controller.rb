class WalletTransfersController < ApplicationController
  def index
    transfers = WalletTransfer.order('created_at desc')
    render locals: { transfers: transfers }
  end
end
