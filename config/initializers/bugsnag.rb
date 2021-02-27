Bugsnag.configure do |config|
  config.api_key = "eee16e119134b568676901929efd056e"
  # config.notify_release_stages = %w(production staging)
  config.send_code = true
  config.send_environment = true
end
