module ActionWallet
  MAX_DAYS = 7
  DEFAULT_DAYS = 2

  # Информация о моем кошельке
  def wallet!(days = DEFAULT_DAYS, *args)
    days = days.to_i
    days = MAX_DAYS if days > MAX_DAYS
    if current_student.present?
      respond_with :message,
        text: multiline(
          current_user.firstname + ', у тебя ' + humanized_stars(current_student.wallet.stars),
          'У всего класса: ' + humanized_stars(study_room.total_stars)
      )
    elsif current_parent.present?
      students = current_parent.children_students.where(study_room_id: study_room)
      if students.any?

        students.each do |student|
          respond_with :message,
            text: multiline(
              "**#{student.name} всего - #{humanized_stars(student.wallet.stars)}**", nil,
              "Отметки за последние #{t('datetime.distance_in_words.x_days', count: days)}:",
              nil,
              *present_wellet_transfers(get_wallet_transfers(student, days)).presence || 'Отсутствуют'),
          parse_mode: :Markdown
        end
      else
        respond_with :message, text: 'Нет учеников чтобы показать отметки'
      end
    else
      respond_with :message, text: 'Странно, но не найдены учащиеся. Обратитесь к администратору'
    end
  end

  private

  def get_wallet_transfers(student, days)
    student.wallet.wallet_transfers.includes(:payer).where('created_at>?', days.days.ago).order('created_at asc')
  end

  def present_wellet_transfers(transfers)
    transfers
      .map { |wt|
      I18n.l(wt.created_at, format: :short) + " - #{wt.payer.name}: #{humanized_stars wt.stars} - #{wt.message}"
    }
  end
end
