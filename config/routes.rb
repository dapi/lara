Rails.application.routes.draw do
  default_url_options Settings.default_url_options.to_h.symbolize_keys

  root 'welcome#index'

  resources :sessions do
    collection do
      delete :destroy
    end
  end
  resources :messages, only: [:index, :show, :new, :create]
  resources :users, only: [:index, :show]
  resources :children_relationships, only: [:create]
  resources :wallet_transfers, only: [:index]
  resources :invites, only: [:destroy]

  get 'ta/:id', action: :create, controller: 'telegram/attach', as: :attach_telegram
  telegram_webhook Telegram::WebhookController unless Rails.env.test?
end
