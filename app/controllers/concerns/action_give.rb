module ActionGive
  MAX_STARS = 10
  # Выдает звездочки
  def give!(*args)
    if is_teacher? || is_superuser?
      clear_selected_students
      reply_with :message, text: "Так-так, сейчас будем раздавать звездочки. Кому?",
        reply_markup: {
        resize_keyboard: true,
        inline_keyboard: students_as_inline_keyboard
      }
    else
      reply_with :message, text: "Звёздочки раздавать могут только учителя"
    end
  end

  def give_stars(stars, *message)
    stars = stars.to_i
    if stars < 1 || stars > MAX_STARS
      save_context :give_stars
      respond_with :message, text: "Количество звёзд должно быть больше 1 и меньше #{MAX_STARS}. Введите число звёзд для #{present_students}"
    else
      session[:give_stars] = stars
      respond_with :message, text: "Выбранный ученик: #{present_students}, дадим #{stars} #{Wallet::STAR}. Напишите за что?"
      save_context :comment_stars_giving
    end
  end

  def comment_stars_giving(*message)
    message = message.join(' ')
    stars = session[:give_stars].to_i
    selected_students.each do |student|
      Accountant
        .new(student.wallet)
        .income!(stars, current_user, message)
    end
    reply_with :message, text: "Выдано #{stars} #{Wallet::STAR} #{present_students} с сообщением '#{message}'"
    session[:give_stars] = nil
    clear_selected_students
  end

  def select_student_callback_query(student_id)
    save_context :give_stars
    add_selected_students Student.find(student_id)

    if selected_students.count == study_room.students.count
      reply_with :message,
        text: multiline( "Даём звёзды всем!", "Напиши числом сколько выдать звёзд"
      )
    else
      reply_with :message,
        text: multiline(
          "Выбранныу ученики: #{present_students}.",
          "Напиши числом сколько выдать звёзд или выбери ещё одного ученика"
      ),
      reply_markup: {
        resize_keyboard: true,
        inline_keyboard: students_as_inline_keyboard(selected_students)
      }
    end
  end

  private

  def present_students(students = selected_students)
    students.map { |s| s.name}.join(', ')
  end

  def students_as_inline_keyboard(excepts = [])
    study_room.
      students.
      where.not(id: excepts).
      where.not(user_id: current_user.id).
      map { |s| { text: s.user.name, callback_data: "select_student:#{s.id}" }}.
      each_slice(2).
      to_a
  end

  def clear_selected_students
    session[:selected_students_ids] = Set.new
  end

  def add_selected_students student
    session[:selected_students_ids] << student.id
  end

  def selected_students
    Student.where id: Array(session[:selected_students_ids])
  end

  def give_stars_callback_query(project_slug)
    save_context :add_time
    project = find_project project_slug
    session[:add_time_project_id] = project.id
    reply_with :message, text: "Вы выбрали проект #{project.slug}, теперь укажите время и через пробел комментарий (12 делал то-то)"
  end
end
