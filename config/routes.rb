Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  namespace :api do
    resources :articles, only: %i[index show create]
    resources :subscriptions, only: :create
  end
end
