Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get root 'cocktails#index'
  resources :cocktails, only: [:show, :new, :create] do
    resources :doses, only: :create
    resources :reviews, only: :create
    # resources :ingredients, only: :create
  end
  resources :doses, only: :destroy
end
