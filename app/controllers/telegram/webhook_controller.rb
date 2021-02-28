class Telegram::WebhookController < Telegram::Bot::UpdatesController
  include StarsHelper
  include HandleErrors

  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::CallbackQueryContext

  #include Telegram::Bot::UpdatesController::Session

  before_action :require_authorization!, except: [:start!]

  # TODO Сохранять ответы в Message
  include ActionStart
  include ActionMessage
  include ActionInvite
  include ActionClass
  include ActionLogin
  include ActionGive
  include ActionHelp
  include ActionWallet

  def callback_query(data)
    Bugsnag.notify "Выбор без контекста, странно"
    edit_message :text, text: "Вы выбрали #{data}"
  end

  def error!
    raise StandardError, 'test error'
  end

  private

  def multiline(*args)
    args.flatten.map(&:to_s).join("\n")
  end

  def require_authorization!
    raise Unauthenticated, (chat || from) unless logged_in?
  end

  def current_user
    return unless from
    return @current_user if defined? @current_user
    @current_user = User.find_by telegram_id: from['id']
  end

  def logged_in?
    current_user.present?
  end

  def study_room
    @study_room ||= find_study_room
  end

  def current_student
    @current_student ||= study_room.students.find_by(user: current_user)
  end

  def find_study_room
    # TODO брать из сессии или вычислять у пользователя или спрашивать его
    StudyRoom.first
  end
end
