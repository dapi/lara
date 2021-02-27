class Telegram::AttachController < ApplicationController
  def create
    info = TelegramVerifier.parse params[:id]
    user = User.find info[:user_id]
    auto_login user
    Telegram.bot.send_message chat_id: user.telegram_id, text: "Вы авторизовались на сайте"
    redirect_to root_path, notice: 'Вы авторизовались!'
  end
end
