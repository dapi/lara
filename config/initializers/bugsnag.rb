
if Rails.application.credentials.bugsnag_api_key.present?
  Bugsnag.configure do |config|
    config.api_key = Rails.application.credentials.bugsnag_api_key
    # config.notify_release_stages = %w(production staging)
    config.send_code = true
    config.send_environment = true
  end
else
  Rails.logger.warn 'Bugsnag is not configured. Setup bugsnag_api_key in credentials'
end
