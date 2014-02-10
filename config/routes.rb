SeatYourself::Application.routes.draw do
  root  'home#welcome'

  get 'signup'          =>        'users#new',            as: :signup
  resources :users

  get 'signin'          =>        'sessions#new',         as: :signin
  get 'signout'         =>        'sessions#destroy',     as: :signout
  resources :sessions,            only: [:create]

  resources :restaurants do
    resources :locations do
      resources :reservations,    except: [:index]
    end
  end



end
