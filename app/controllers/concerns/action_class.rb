module ActionClass
  # Информация о классе
  def class!
    reply_with :message,
      text: multiline(study_room.title, nil,
                      'Ученики: ' + study_room.student_users.map(&:full_name).join(', '),
                      'Учетиля: ' + study_room.teacher_users.map(&:full_name).join(', '),
                      'Родители: ' + study_room.parents.map(&:full_name).join(', '),
                      'У всего класса: ' + humanized_stars(study_room.total_stars)
                     )
  end
end
