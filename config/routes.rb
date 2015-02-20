Rails.application.routes.draw do
  # root 'jobs#index'
  root 'home#index'
  # get 'home/index', controller: 'home', as: 'welcome'
  resources :jobs
end
