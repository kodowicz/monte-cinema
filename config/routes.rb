Rails.application.routes.draw do
  resources :ticket_desks, only: %i[show create update destroy] do
    resources :reservations, only: %i[index show create update destroy] do
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

  resources :clients, only: %i[show create update destroy] do
    resources :reservations, only: %i[index show destroy] do
      resources :tickets, only: %i[index show destroy]
    end
  end
end