Rails.application.routes.draw do
  default_url_options Settings.default_url_options.to_h.symbolize_keys

  root 'welcome#index'

  resources :messages

  get 'ta/:id', action: :create, controller: 'telegram/attach', as: :attach_telegram
  telegram_webhook Telegram::WebhookController unless Rails.env.test?
end
