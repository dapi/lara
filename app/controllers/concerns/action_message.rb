module ActionMessage
  # Принимает сообщение
  def message(payload)
    return if chat['id'].negative?  # Групповой чат
    current_user
      .messages
      .create!(text: payload['text'],
               payload: payload,
               chat_id: chat['id'],
               message_id: payload['message_id'],
               reply_to_message_id: payload.dig('reply_to_message', 'message_id')
              )
    calc = Calculator.new payload['text']
    if calc.is_expression?
      reply_with :message, text: calc.call
    else
      reply_with :message, text: "Я не понимаю"
    end
  end
end
