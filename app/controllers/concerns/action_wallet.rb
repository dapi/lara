module ActionWallet
  # Информация о моем кошельке
  def wallet!
    if current_student.present?
      reply_with :message,
        text: multiline(
          current_user.firstname + ', у тебя ' + humanized_stars(current_student.wallet.stars),
          'У всего класса: ' + humanized_stars(study_room.total_stars)
      )
    elsif current_parent.present?
      students = current_parent.children_students.where(study_room_id: study_room)
      if students.any?
        reply_with :message, text: multiline(*students.map { |s| "#{s.name}: #{humanized_stars(s.wallet.stars)}"} )
      else
        reply_with :message, text: 'Странно, но не найдены учащиеся. Обратитесь к администратору'
      end
    end
  end
end
