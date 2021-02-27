class TelegramVerifier
  include Singleton

  self.class.delegate :build_link, :parse, to: :instance

  def build_link(payload)
    Rails.application.routes.url_helpers.attach_telegram_url verifier.generate(payload)
  end

  def parse(token)
    verifier.verify token
  end

  private

  def verifier
    @verifier ||= ActiveSupport::MessageVerifier.new Rails.application.credentials.secret_key_base || 'fake_for_testing'
  end
end
