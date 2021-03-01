class TelegramActions
  IGNORE_ACTIONS = %i[cancel! try! !]

  # Возращает список акций
  #
  def perform
    Telegram::WebhookController
      .instance_methods
      .filter { |s| !IGNORE_ACTIONS.include?(s) && s.ends_with?('!') }
      .sort
      .each_with_object({}) do |method, hash|
      hash[method]=Telegram::WebhookController.instance_method(method).comment.gsub(/^#\s+/,'').presence
    end
  end
end
