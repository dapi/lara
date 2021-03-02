module ActionPeople
  # Список людей в классе
  def people!
    reply_with :message,
      text: multiline(study_room.title, nil,
                      'Ученики: ' + (study_room.student_users.map(&:full_name).join(', ').presence || 'Пока не зарегистрированы'),
                      nil,
                      'Учителя: ' + (study_room.teacher_users.map(&:full_name).join(', ').presence || 'Пока не зарегистрированы'),
                      nil,
                      'Родители: ' + (study_room.parents.map(&:full_name).join(', ').presence || 'Пока не зарегистрированы'),
                      nil,
                      'Классный руководитель: ' + study_room.classroom_teacher.try(:full_name).presence || 'Пока не установле'
                     )
  end
end
