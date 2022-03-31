Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users
  resources :pagetops, only: [:index]
  resources :follows, only: [:create, :update, :destroy]
  resources :went_survfields, only: [:index, :create, :destroy]
  resources :regularmeetings
  resources :follow_regularmeetings, only: [:create, :update, :destroy]
  resources :comment_meetings, only: [:create, :update, :destroy]

  get 'survfields/index'
  get 'survfields/show'
  root to: "pagetops#index" 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
