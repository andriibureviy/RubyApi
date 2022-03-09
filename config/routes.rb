Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users
      resources :articles do
        resources :comments
      end
    end
  end
end
