# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :ticket_desks, only: %i[show] do
    resources :reservations, only: %i[index show create destroy] do
      collection do
        post '/online', to: 'reservations#create_online'
        post '/offline', to: 'reservations#create_offline'
      end

      resources :tickets, only: %i[index show destroy]
    end
  end

  resources :movies, only: %i[index show] do
    collection do
      get '/popular', to: 'movies#popular'
    end

    resources :screenings, only: %i[index show]
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'signup', to: 'users/registrations#create'
    post 'login', to: 'users/sessions#create'
    delete 'logout', to: 'users/sessions#destroy'
  end

  resources :clients, only: %i[show create update destroy] do
    resources :reservations, only: %i[index show create destroy] do
      resources :tickets, only: %i[index show destroy]
    end
  end

  MonteCinema::Application.routes.draw do
    mount Sidekiq::Web => '/sidekiq'
  end
end
