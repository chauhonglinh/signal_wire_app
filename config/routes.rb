Rails.application.routes.draw do
  namespace :api do
    resources :tickets, only: [:create]
  end
end
