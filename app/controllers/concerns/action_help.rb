module ActionHelp
  def help!(*)
    reply_with :message, text: Settings.help_message
  end

  def admin!(*)
    reply_with :message, text: Settings.admin_message
  end
end
