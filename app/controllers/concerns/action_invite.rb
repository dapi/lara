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
end
