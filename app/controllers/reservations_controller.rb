class ReservationsController <ApplicationController
  def new
    @location = Location.find(params[:location_id])
    @reservation = @location.reservations.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    @reservations = Reservation.all
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

  private
  def reservation_params
    params.require(:reservation).permit(:time,:number_of_people)
  end
end