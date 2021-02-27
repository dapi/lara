class Telegram::WebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  #include Telegram::Bot::UpdatesController::MessageContext
  #include Telegram::Bot::UpdatesController::CallbackQueryContext

  Error = Class.new StandardError
  Unauthenticated = Class.new Error
  before_action :require_authorization!

  rescue_from StandardError, with: :handle_error

  def message(message)
    respond_with :message, text: "Я не понимаю что: #{message['text']}?"
  end

  def start!(word = nil, *other_words)
    response = from ? "Hello #{from['username']}!" : 'Hi there!'
    respond_with :message, text: response
  end

  private

  attr_reader :current_user

  def multiline(*args)
    args.flatten.map(&:to_s).join("\n")
  end

  def require_authorization!
    raise Unauthenticated unless logged_in?
  end

  def current_user
    return unless from
    return @current_user if defined? @current_user
    @current_user = User.where(telegram_id: from['id'])
  end

  def logged_in?
    current_user.present?
  end

  def handle_error(error)
    case error
    when Telegram::Bot::Forbidden
      Bugsnag.notify error
      logger.error(error)
    when Unauthenticated
      respond_with :message, text: multiline(
        "Привет, #{from['first_name']}!",
        nil,
        "К сожалению мы с тобой не знакомы. Обратись к своему классному руководителю чтобы он нас познакомил.",
        nil,
        "Твоя Лара."
      )
    else # ActiveRecord::ActiveRecordError
      logger.error error
      Bugsnag.notify error do |b|
        b.meta_data = { chat: chat, from: from }
      end
      respond_with :message, text: "Error: #{error.message}"
    end
  end
end
