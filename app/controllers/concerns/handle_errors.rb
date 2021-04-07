module HandleErrors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle_error
  end

  def handle_error(error)
    case error
    when Telegram::Bot::Forbidden
      Bugsnag.notify error
      logger.error(error)
    when Unauthenticated
      Bugsnag.notify error do |b|
        b.meta_data = { from: from, chat: chat }
      end
      respond_with :message, text: multiline(
        "Привет, #{from.fetch( 'first_name', 'незнакомец!' )}!",
        nil,
        "К сожалению мы с тобой не знакомы. Обратись к своему классному руководителю чтобы он нас познакомил.",
        nil,
        "Твоя Лара."
      )
    else # ActiveRecord::ActiveRecordError
      #binding.pry if Rails.env.development?
      logger.error error
      Bugsnag.notify error do |b|
        b.meta_data = { chat: chat, from: from }
      end
      respond_with :message, text: 'Произошла какая-то ошибка. Поддержка уже в пути!'
    end
  end
end
