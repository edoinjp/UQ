Rails.application.routes.draw do
  devise_for :users
  root to: "home#home"  # Root path for the home action in HomeController

  resources :classrooms, only: [:index, :new, :create, :show] do
    member do
      post 'add_students'
      get 'students'
    end
    resources :lessons, only: %i[index]
  end

  resources :users, only: [:show]
  get 'vark', to: 'users#test'
  post 'vark', to: 'users#submit'

  resources :lessons, only: %i[show] do
    resources :questions, only: [:index]
    resources :responses, only: [:index]
  end
end
