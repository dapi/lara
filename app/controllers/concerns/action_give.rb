module ActionGive
  # Выдает звездочки
  def give!(*args)
    reply_with :message, text: 'test'
    save_context :giving_in_progress
  end
end
