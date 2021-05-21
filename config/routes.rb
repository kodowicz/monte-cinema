Rails.application.routes.draw do
  resources :cinema_halls #only: [:index, :show, :create, :update, :destroy]
end
