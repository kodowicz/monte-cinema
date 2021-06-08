require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :ticket_desks, only: %i[show] do
    resources :reservations, only: %i[index show create destroy] do
      resources :tickets, only: %i[index show destroy]
    end
  end

  resources :movies, only: %i[index show] do
    resources :screenings, only: %i[index]
  end

  resources :clients, only: %i[show create update destroy] do
    resources :reservations, only: %i[index show create destroy] do
      resources :tickets, only: %i[index show destroy]
    end
  end

  MonteCinema::Application.routes.draw do
    mount Sidekiq::Web => "/sidekiq"
  end
end
