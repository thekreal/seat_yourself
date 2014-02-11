SeatYourself::Application.routes.draw do
  root  'home#welcome'

  get 'signin'          =>      'sessions#new',          as: :signin
  get 'signout'         =>      'sessions#destroy',      as: :signout
  resources :sessions,          only: [:create]

  get 'member_signup'   =>      'members#new',           as: :member_signup
  resources :members

  get 'owner_signup'    =>      'restaurant_owers#new',  as: :owner_signup
  resources :restaurant_owers

  resources :restaurants do
    resources :locations
  end

  resources :reservations,  except: [:index]

end
