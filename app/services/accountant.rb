class Accountant
  def initialize(wallet)
    @wallet = wallet
  end

  def income!(stars, payer)
    raise 'Звёзд должно быть положительное количество' unless stars.positive?
    wallet.with_lock do
      wallet.update stars: wallet.stars + stars
    end

    owner = wallet.student.user

    SendMessageJob.perform_async(
      chat_ids: owner.telegram_id,
      text: "#{payer.name} дал вам #{stars} #{Wallet::STAR}. Теперь у вас #{wallet.humanized}!"
    )
  end

  private

  attr_reader :wallet
end
