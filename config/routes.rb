Rails.application.routes.draw do

  root 'home#index'
  get 'companies/index'

  devise_for :users, controllers: { registrations: "registrations" }

  resources :users,     only: [:new, :create, :show, :update]
  resources :companies, only: [:index, :new, :create, :show, :edit ]
  resources :jobs,      only: [:index, :new, :create, :show, :edit ]
end
