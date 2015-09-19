Rails.application.routes.draw do
  resources :forms, only: [:index, :new, :create] do
    member do
      post :generate_pdf
    end
  end
  root 'forms#index'
end
