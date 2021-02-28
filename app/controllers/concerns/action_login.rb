module ActionLogin
  # Отправляет в чат ссылку на логин на web-е
  def login!
    link = TelegramVerifier.build_link user_id: current_user.id
    reply_with :message,
      text: "Сходите по ссылке #{link} чтобы атворизоваться"
  end
end
