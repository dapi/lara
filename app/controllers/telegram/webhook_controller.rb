class Telegram::WebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  #include Telegram::Bot::UpdatesController::MessageContext
  #include Telegram::Bot::UpdatesController::CallbackQueryContext

  Error = Class.new StandardError
  Unauthenticated = Class.new Error
  before_action :require_authorization!, except: [:start!]

  rescue_from StandardError, with: :handle_error

  def message(message)
    current_user.messages.create!(text: message['text'], payload: message, chat_id: chat['id'])
    respond_with :message, text: "Я не понимаю что: #{message['text']}?"
  end

  def start!(message = '', *args)
    if logged_in?
      respond_with :message, text: "#{current_user.firstname}, привет снова!"
    elsif message.gsub!(/^i_/,'')
      invite = Invite.find_by(key: message)
      if invite.present?
        accept_invite! invite
      else
        respond_with :message,
          text: 'Похоже у Вас устаревшая ссылка, обратитесь к тому кто вам её выдал чтобы дали новую!'
      end
    else
      raise Unauthenticated
    end
  end

  private

  attr_reader :current_user

  def accept_invite!(invite)
    invite.with_lock do
      user = User
        .create!(full_name: invite.full_name, telegram_id: from['id'], telegram_info: from)
      @current_user = user
      case invite.role
      when 'parents'
      when 'students'
        invite.study_room.student_users << user
      when 'teacher'
        invite.study_room.teacher_users << user
      else
        raise "Unknown invite role #{invite.role} for #{invite.id}"
      end

      respond_with :message,
        text: multiline("Привет, #{user.name}!",
                        "Я Лара - личный помощник по учебной части. Теперь я знаю что ты #{Invite.human_enum_name :role, invite.role} в #{invite.study_room.title}")
      invite.destroy!
    end
  end

  def multiline(*args)
    args.flatten.map(&:to_s).join("\n")
  end

  def require_authorization!
    raise Unauthenticated unless logged_in?
  end

  def current_user
    return unless from
    return @current_user if defined? @current_user
    @current_user = User.find_by telegram_id: from['id']
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
      binding.pry if Rails.env.development?
      logger.error error
      Bugsnag.notify error do |b|
        b.meta_data = { chat: chat, from: from }
      end
      respond_with :message, text: 'Произошла какая-то ошибка. Поддержка уже в пути!'
    end
  end
end
