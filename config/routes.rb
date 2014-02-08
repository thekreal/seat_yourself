SeatYourself::Application.routes.draw do
  root  'home#welcome'

  resources :users

  resources :restaurants do
    resources :locations
  end

  resources :reservations

end
