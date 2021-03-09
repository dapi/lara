module ActionGive
  MAX_STARS = 10
  # Выдает звездочки
  def give!(*args)
    if is_teacher?
      session[:selected_student_id] = nil
      inline_keyboard = study_room
        .students
        .where.not(user_id: current_user.id)
        .map { |s| { text: s.user.name, callback_data: "select_student:#{s.id}" }}
        .each_slice(2)
        .to_a
      reply_with :message, text: "Так-так, сейчас будем раздавать звездочки. Кому?",
        reply_markup: {
        resize_keyboard: true,
        inline_keyboard: inline_keyboard
      }
    else
      reply_with :message, text: "Звёздочки раздавать могут только учителя"
    end
  end

  def give_stars(stars, *message)
    student = Student.find session[:selected_student_id]
    stars = stars.to_i
    if stars < 1 || stars > MAX_STARS
      save_context :give_stars
      respond_with :message, text: "Количество звёзд должно быть больше 1 и меньше #{MAX_STARS}. Введите число звёзд дла #{student.name}"
    else
      session[:give_stars] = stars
      respond_with :message, text: "Выбранный ученик: #{student.name}, дадим #{stars} #{Wallet::STAR}. Напишите за что?"
      save_context :comment_stars_giving
    end
  end

  def comment_stars_giving(*message)
    message = message.join(' ')
    student = Student.find session[:selected_student_id]
    stars = session[:give_stars].to_i
    Accountant.new(student.wallet).income!(stars, current_user, message)
    reply_with :message, text: "Выдано #{stars} #{Wallet::STAR} #{student.name} с сообщением '#{message}'"
    session[:give_stars] = nil
    session[:selected_student_id] = nil
  end

  def select_student_callback_query(student_id)
    student = Student.find student_id
    save_context :give_stars
    session[:selected_student_id] = student_id
    reply_with :message, text: multiline("Выбранный ученик: #{student.name}.", "Напиши числом сколько дадим звёзд?")
  end

  private


  def give_stars_callback_query(project_slug)
    save_context :add_time
    project = find_project project_slug
    session[:add_time_project_id] = project.id
    reply_with :message, text: "Вы выбрали проект #{project.slug}, теперь укажите время и через пробел комментарий (12 делал то-то)"
  end
end
