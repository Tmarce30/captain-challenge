Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :personnages

  resources :combats, only: [:show, :new, :create]

  root to: 'pages#home'
end
