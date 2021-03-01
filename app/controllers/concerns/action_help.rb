module ActionHelp
  # Выводит доступный список команд
  def help!(*)
    reply_with :message, text: multiline("Привет, #{current_user.full_name}!", Settings.help_message)
  end

  # Выводит список команд для администрирования
  def admin!(*)
    reply_with :message, text: Settings.admin_message
  end
end
