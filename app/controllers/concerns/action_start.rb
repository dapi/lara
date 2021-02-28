module ActionStart
  def start!(message = '', *args)
    if logged_in?
      reply_with :message,
        text: multiline("#{current_user.firstname}, привет!", nil, Settings.welcome_message)
    elsif message.gsub!(/^i_/,'')
      invite = Invite.find_by(key: message)
      if invite.present?
        accept_invite invite
      else
        reply_with :message,
          text: 'Похоже у Вас устаревшая ссылка, обратитесь к тому кто вам её выдал чтобы дали новую!'
      end
    else
      raise Unauthenticated
    end
  end

  private

  def accept_invite(invite)
    invite.with_lock do
      user = User
        .create!(full_name: invite.full_name, telegram_id: from['id'], telegram_info: from)
      @current_user = user
      case invite.role
      when 'parents'
      when 'student'
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
end
