class MessagesController < ApplicationController
  def index
    messages = Message.order('created_at desc')
    render locals: { messages: messages }
  end

  def new
    message = Message.new(permitted_params)
    original_message = Message.find_by(chat_id: message.chat_id, message_id: message.reply_to_message_id)
    render locals: { message: message, original_message: original_message }
  end

  def create
    message = Message.new permitted_params

    # TODO Замениь на SendMessageJob
    original_message = Message.find_by(chat_id: message.chat_id, message_id: message.reply_to_message_id)
    message.user = original_message.user
    response = Telegram.bot.send_message message.slice(:chat_id, :text, :reply_to_message_id)
    message.payload = response['result']
    message.message_id = message.payload['message_id']
    message.save!

    redirect_to messages_path(message_id: message.id)
  end

  def show
    message = Message.find params[:id]
    render locals: { message: message }
  end

  private

  def permitted_params
    params.require(:message).permit(:reply_to_message_id, :text, :chat_id)
  end
end

