module ActionLogin
  # Отправляет в чат ссылку на авторизацию на сайте
  def login!
    link = TelegramVerifier.build_link user_id: current_user.id
    reply_with :message,
      text: "Кликните на ссылке #{link} чтобы атворизоваться на сайте"
  end
end
