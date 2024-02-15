Rails.application.routes.draw do
  devise_for :users
  root to: "home#home"  # Root path for the home action in HomeController

  resources :classrooms, only: %i[index new create show]
  resources :users, only: [:show]
  resources :lessons, only: %i[index show] do
    resources :questions, only: [:index]
    resources :responses, only: [:index]
  end

  resources :classrooms do
    member do
      post 'add_students'
    end
  end
end
