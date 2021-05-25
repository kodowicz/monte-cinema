Rails.application.routes.draw do
  resources :ticket_desks, only: %i[show create update destroy] do 
    resources :reservations, only: %i[index show create update destroy] do 
      resources :tickets, only: %i[index show destroy]
    end
  end 

  resources :cinema_halls
end