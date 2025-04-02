Rails.application.routes.draw do
  root "landing#index"

  get "signup", to: "users#new", as: "user_signup"
  post "signup", to: "users#create"
  get "cancel-ticket/:id", to: "tickets#cancel", as: "cancel_ticket"

  get "login", to: "sessions#new", as: "user_login"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy", as: "user_logout"

  resources :users, only: [ :show, :edit, :update, :destroy ]


  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }


  authenticated :admin do
    root to: "admin/dashboard#index", as: :authenticated_admin_root
  end


  resources :tickets do
    member do
      patch :cancel
    end
  end


  resources :shows
  resources :movies
  resources :screens
  resources :admins, only: [:index, :show, :edit, :update]
  resources :home, only: [:index]

  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    resources :sessions, only: [:new, :create, :destroy]

    # Admin can manage movies & their shows
    resources :movies do
      resources :shows, only: [:index, :new, :create, :edit, :update, :destroy]
    end

    # Admin can manage users and view their tickets
    resources :users do
      member do
        get :tickets
      end
    end
    resources :admins
    resources :tickets
    resources :shows do
      resources :tickets, only: [:create]
    end

    # Admin can manage tickets
    resources :tickets, only: [:index, :destroy]

    # Admin profile management (Admin can update their info)
    resources :admins, only: [:index, :show, :edit, :update]
  end

  # User Routes (Users can only view & book tickets)
  resources :users, only: [:show, :edit, :update] do
    member do
      get :tickets  # View user's booked tickets
    end
  end

  # Movies & Shows (Public users can view)
  resources :movies do
    resources :shows
  end
  resources :shows

  # Shows & Ticket Booking (Users can book tickets)
  resources :shows, only: [:index, :show] do
    resources :tickets, only: [:create]
  end
  resources :movies do
    resources :shows, only: [:index]
  end  
  resources :users do
    member do
      get :tickets
    end
  end
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Tickets (User can view their tickets)
  resources :tickets, only: [:index, :show]


  # Home Page Route
  get "home", to: "home#index", as: "home"
end
