class LocationsController < ApplicationController
  before_action :set_restaurant, except: [:show, :destroy]
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = @restaurant.locations.all
  end

  def show
    @restaurant = @location.restaurant
  end

  def new
    @location = @restaurant.locations.new
  end

  def create
    @location = @restaurant.locations.new(location_params)
    if @location.save
      flash[:success] = "Location created successfully"
      redirect_to @location
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      flash[:success] = "Location updated successfully"
      redirect_to [@restaurant, @location]
    else
      render :edit
    end
  end

  def destroy

    if @location.destroy
      flash[:success] = "Location removed successfully"
      redirect_to @restaurant
    end
  end

private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:address, :number_of_seats, :open_at, :close_at )
  end

end