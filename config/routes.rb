require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :ticket_desks, only: %i[show] do
    resources :reservations, only: %i[index show create destroy] do
      resources :tickets, only: %i[index show destroy]
    end
  end

  # create screenings of a movie in available halls
  resources :cinema_halls, only: %i[index show create update destroy] do
    resources :screenings, only: %i[index create update destroy]
  end

  # get all available screenings of a movie for a user
  resources :movies, only: %i[index show create update destroy] do
    resources :screenings, only: %i[index]
  end

  # get all user's reservations and tickets
  resources :clients, only: %i[show create update destroy] do
    resources :reservations, only: %i[index show create destroy] do
      resources :tickets, only: %i[index show destroy]
    end
  end

  # choose seats of a hall to create tickets
  resources :screenings, only: %i[index show] do
    resources :cinema_halls, only: %i[show]
  end

  MonteCinema::Application.routes.draw do
    mount Sidekiq::Web => "/sidekiq"
  end
end
