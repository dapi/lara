module ActionInvite
  # Пригласить человека на роль
  def invite!(role = nil, *full_name)
    if role.present? && full_name.present?
      invite = current_user.invites.create!(
        full_name: full_name.join(' '),
        role: role,
        study_room: study_room
      )
      reply_with :message, text: "Отправьте #{invite.full_name} эту ссылку для регистрации - #{invite.telegram_attach_url}"
    else
      reply_with :message, text: 'Укажите роль (student, parents, teacher) и ФИО. Например: /invite student Письменная Агата'
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
