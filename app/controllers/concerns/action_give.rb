module ActionGive
  # Выдает звездочки
  def give!(*args)
    save_context nil
    session[:selected_student_id] = nil
    reply_with :message, text: "Так-так, сейчас будем раздавать звездочки. Кому?",
      reply_markup: {
      resize_keyboard: true,
      inline_keyboard: study_room.students.map { |s| { text: s.user.name, callback_data: "select_student:#{s.id}" }}.each_slice(3).to_a
    }
  end

  def give_stars(stars, *message)
    student = Student.find session[:selected_student_id]
    session[:give_stars] = stars
    reply_with :message, text: "Выбранный ученик: #{student.name}, дадим #{stars} #{Wallet::STAR}. Напишите за что?"
    save_context :comment_stars_giving
  end

  def comment_stars_giving(*message)
    message = message.join(' ')
    student = Student.find session[:selected_student_id]
    stars = session[:give_stars].to_i
    Accountant.new(student.wallet).income!(stars, message)
    reply_with :message, text: "Выдала #{stars} #{student.name} с сообщением #{mesage}"
    session[:give_stars] = nil
    session[:selected_student_id] = nil
  end

  def select_student_callback_query(student_id)
    student = Student.find student_id
    edit_message :text, text: "Выбранный ученик: #{student.name}. Напиши числом сколько дадим звёзд?"
    save_context :give_stars
    session[:selected_student_id] = student_id
  end

  private


  def give_stars_callback_query(project_slug)
    save_context :add_time
    project = find_project project_slug
    session[:add_time_project_id] = project.id
    edit_message :text, text: "Вы выбрали проект #{project.slug}, теперь укажите время и через пробел комментарий (12 делал то-то)"
  end
end
