Rails.application.routes.draw do
  namespace :api do
    resources :articles, only: %i[index show]
    # get :articles, controller: :articles, action: :index
    # get :articles, controller: :articles, action: :show
  end
end
