Rails.application.routes.draw do
  get 'pages/home'
  resources :recipes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
end 
