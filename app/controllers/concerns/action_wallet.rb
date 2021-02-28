module ActionWallet
  # Информация о моем кошельке
  def wallet!
    if current_student.present?
      reply_with :message,
        text: multiline(
          current_user.firstname + ', у тебя ' + humanized_stars(current_student.wallet.stars),
          'У всего класса: ' + humanized_stars(study_room.total_stars)
      )
    else
      reply_with :message, text: 'Звезды есть только у учеников'
    end
  end
end
