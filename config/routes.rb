Rails.application.routes.draw do
  root to: 'ticket_desks#index'
  resources :cinema_halls
  resources :ticket_desks
  resources :tickets
  resources :reservations
end
