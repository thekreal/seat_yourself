SeatYourself::Application.routes.draw do
  root  'home#welcome'


  resources :restaurants do
    resources :locations do
    	resources :reservations
  	end
  end


end
