Rails.application.routes.draw do
  namespace :api do
    get :articles, controller: :articles, action: :index
  end
end
