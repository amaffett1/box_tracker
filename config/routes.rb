Rails.application.routes.draw do
  # ✅ Autenticazione con Devise
  devise_for :users

  # ✅ Home page diversa se loggato o meno
  authenticated :user do
    root to: "boxes#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "devise/sessions#new", as: :unauthenticated_root
  end

  # ✅ Rotte principali dell’app
  resources :boxes do
    resources :items, only: [:index, :show, :edit, :update, :destroy]
  end

  # ✅ Movimenti indipendenti
  resources :movements, only: [:index, :create]
end
