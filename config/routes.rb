SeatYourself::Application.routes.draw do
  root  'home#welcome'

  resources :restaurants do
    resources :locations, except: [:index]
  end

end
