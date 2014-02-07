class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
    @restaurant.locations.build
  end

  def create
    @restaurant = Restaurant.new(new_restaurant_params)
    if @restaurant.save
      redirect_to @restaurant
    else
      render :new
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      flash[:info] = "Success"
      redirect_to @restaurant
    else
      render :edit
    end
  end

  def destroy
  end

private

  def set_restaurant
  end

  def new_restaurant_params
    params.require(:restaurant).permit( :name, :description,
                                        locations_attributes: [
                                          :address, :number_of_seats, :open_at, :close_at ])
  end

  def edit_restaurant_params
    params.require(:restaurant).permit( :name, :description )
  end

end