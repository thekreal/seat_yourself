class ReservationsController <ApplicationController

  before_action :set_restaurant
  before_action :set_location

  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = @location.reservations.new
  end

  def create
    @reservation = @location.reservations.new(reservation_params)
    @reservation.user_id = current_user.id
    if @reservation.save
      redirect_to current_user
    else
      render :new
    end
  end



  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update_attributes(reservation_params)
      redirect_to reservations_path
    else
      render :edit
    end
  end

  def destroy
     @reservation = Reservation.find(params[:id])
     @reservation.destroy
     redirect_to user_path(params[:id] = current_user.id)
  end

  private
  def reservation_params
    params.require(:reservation).permit(:time,:number_of_people)
  end

  def set_location
    @location = Location.find(params[:location_id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end