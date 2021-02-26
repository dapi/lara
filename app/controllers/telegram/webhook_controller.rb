class Telegram::WebhookController < Telegram::Bot::UpdatesController
  def message(message)
    respond_with :message, text: "Я не понимаю что: #{message['text']}?"
  end

  def start!(word = nil, *other_words)
    response = from ? "Hello #{from['username']}!" : 'Hi there!'
    respond_with :message, text: response
  end
end
