module ActionClass
  # Информация о классе. Общее количество звёзд
  def class!(*args)
    reply_with :message,
      text: multiline(study_room.title, nil,
                      *study_room.students.includes(:wallet).map { |s| "#{s.name}: " + humanized_stars(s.wallet.stars) },
                      nil,
                      '**У всего класса: ' + humanized_stars(study_room.total_stars) + '**'
                     ),
       parse_mode: :Markdown
  end
end
