Rails.application.routes.draw do

  post 'users/signup', to: 'users#signup'
  post 'users/login', to: 'sessions#create'

  resources :venues, only: [:index, :create, :update, :destroy] do
    resources :events, only: [:index, :create]
  end

  resources :events, only: [:update, :destroy]

  resources :bookings, only: [:index, :destroy] do
    member do
      put 'approve'
      put 'reject'
    end
  end

  post 'events/:event_id/bookings', to: 'bookings#create', as: :event_bookings

  get 'events/search', to: 'events#search'
end
