module ActionClass
  # Информация о классе
  def class!
    reply_with :message,
      text: multiline(study_room.title, nil,
                      'Ученики: ' + (study_room.student_users.map(&:full_name).join(', ').presence || 'Пока не зарегистрированы'),
                      'Учителя: ' + (study_room.teacher_users.map(&:full_name).join(', ').presence || 'Пока не зарегистрированы'),
                      'Родители: ' + (study_room.parents.map(&:full_name).join(', ').presence || 'Пока не зарегистрированы'),
                      'У всего класса: ' + humanized_stars(study_room.total_stars)
                     )
  end
end
