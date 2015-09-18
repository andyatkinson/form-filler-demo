Rails.application.routes.draw do
  resources :forms
  root 'forms#index'
end
