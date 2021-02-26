Rails.application.routes.draw do
  default_url_options Settings.default_url_options.to_h.symbolize_keys
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get 'ta/:id', action: :create, controller: 'telegram/attach', as: :attach_telegram

  root 'welcome#index'
  telegram_webhook Telegram::WebhookController unless Rails.env.test?
end
