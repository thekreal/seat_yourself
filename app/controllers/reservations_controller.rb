class ReservationsController <ApplicationController
  before_action :set_location, only: [:new, :create, :edit, :update]
  before_action :set_reservation, except: [:new, :create,]
  def show
  end

  def new
    @reservation = @location.reservations.new
  end

  def create
    @reservation = @location.reservations.new(reservation_params)
    @reservation.member_id = current_user.id
    if @reservation.save
      redirect_to current_user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to current_user
    else
      render :edit
    end
  end

  def destroy
     @reservation.destroy
     redirect_to current_user
  end

private

  def reservation_params
    params.require(:reservation).permit(:date, :time, :number_of_people)
  end

  def set_location
    @location = Location.find(params[:location_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

end