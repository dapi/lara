class TelegramActions
  IGNORE_ACTIONS = %i[cancel! try! !]

  # Возращает список акций
  #
  def perform
    Telegram::WebhookController
      .instance_methods
      .filter { |s| !IGNORE_ACTIONS.include?(s) && s.ends_with?('!') }
    #  method=Telegram::WebhookController.instance_method(:start!)
    #  method.comment
  end
end
