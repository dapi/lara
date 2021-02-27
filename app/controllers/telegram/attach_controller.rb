class Telegram::AttachController < ApplicationController
  def create
    info = TelegramVerifier.parse params[:id]
    Telegram.bot.send_message chat_id: info[:uid], text: "Спасибо, теперь я знаю, что ты – #{current_user} на сайте. Дальше напиши /help"
  rescue Telegram::Bot::Forbidden
  end
end
