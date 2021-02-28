
if Rails.application.credentials.bugsnag_api_key.present?
  Bugsnag.configure do |config|
    config.api_key = Rails.application.credentials.bugsnag_api_key
    # config.notify_release_stages = %w(production staging)
    config.send_code = true
    config.send_environment = true
    #config.add_on_error(proc do |report|
      #report.user = {
        #id: current_user.id,
        #email: current_user.email,
        #name: current_user.name
      #}
    #end)
  end
else
  Rails.logger.warn 'Bugsnag is not configured. Setup bugsnag_api_key in credentials'
end
