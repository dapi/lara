# Отправляет сообщение кому надо
#
class SendMessageJob < ApplicationJob
  queue_as :default

  # https://core.telegram.org/bots/api#sendmessage

  # user - кому сообщение
  # @return - Array[Message]
  def perform(text: , chat_ids: [], user: nil)
    Array(chat_ids).map do |chat_id|
      response = Telegram.bot.send_message(
        chat_id: chat_id,
        text: text
      )
      user ||= User.find_by(telegram_id: chat_id)
      Message.create!(
        user: user,
        chat_id: chat_id,
        text: text,
        payload: response['result'],
        message_id: response['message_id']
      ) if user.present?
    end
  end
end
