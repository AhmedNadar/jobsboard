Rails.application.routes.draw do

  get 'companies/index'

  devise_for :users, controllers: { registrations: "registrations" }
  root 'home#index'

  resources :jobs do
    resources :companies, only: [:new, :create ]
      # resources :users, only: [:new, :create, :show, :update]

  end
end
