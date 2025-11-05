Rails.application.routes.draw do
  # ✅ Devise gestisce login/logout/signup
  devise_for :users

  # ✅ Home page diversa se loggato o meno
  authenticated :user do
    root to: "boxes#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "devise/sessions#new", as: :unauthenticated_root
  end

  # ✅ Rotte principali della tua app
  resources :boxes do
    resources :items
  end

  resources :movements, only: [:index, :create]
end
