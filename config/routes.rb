Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :classrooms, only: %i[index new create show]
  resources :users, only: [:show]
  resources :lessons, only: %i[index show] do
    resources :questions, only: [:index]
  end
end
