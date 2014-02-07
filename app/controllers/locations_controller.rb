class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @location = @restaurant.locations.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
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
      redirect_to @location
    else
      render :edit
    end
  end

  def destroy
    restaurant = @location.restaurant
    if @location.destroy
      flash[:success] = "Location removed successfully"
      redirect_to restaurant
    end
  end

private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:address, :number_of_seats, :open_at, :close_at )
  end

end