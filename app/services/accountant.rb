class Accountant
  include StarsHelper

  def initialize(wallet)
    @wallet = wallet
  end

  def income!(stars, payer, message)
    raise 'Звёзд должно быть положительное количество' unless stars.positive?
    wallet.with_lock do
      wallet.update stars: wallet.stars + stars
    end

    owner = wallet.student.user

    SendMessageJob.perform_later(
      chat_ids: owner.telegram_id,
      text: "Поступило #{Wallet::STAR * stars} от #{payer.name} за #{message}. Теперь у тебя #{humanized_stars wallet.stars}!"
    )
  end

  private

  attr_reader :wallet
end
