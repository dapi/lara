module ActionClass
  # Информация о классе. Общее количество звёзд
  def class!
    reply_with :message,
      text: multiline(study_room.title, nil,
                      'У всего класса: ' + humanized_stars(study_room.total_stars)
                     )
  end
end
