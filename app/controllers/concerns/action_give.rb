module ActionGive
  # Выдает звездочки
  def give!(*args)
    reply_with :message, text: "Так-так, сейчас будем раздавать звездочки. Кому?",
    reply_markup: {
      resize_keyboard: true,
      inline_keyboard: []
        #current_user.available_projects.alive.
        #map { |p| { text: p.name, callback_data: "give_stars:#{p.slug}" } }.
        #each_slice(3).to_a
    }
    save_context :giving_in_progress
  end

  private


  def give_stars_callback_query(project_slug)
    save_context :add_time
    project = find_project project_slug
    session[:add_time_project_id] = project.id
    edit_message :text, text: "Вы выбрали проект #{project.slug}, теперь укажите время и через пробел комментарий (12 делал то-то)"
  end

end
