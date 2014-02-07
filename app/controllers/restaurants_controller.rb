class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

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
      flash[:success] = "Restaurant created successfully"
      redirect_to @restaurant
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @restaurant.update(edit_restaurant_params)
      flash[:success] = "Restaurant updated successfully"
      redirect_to @restaurant
    else
      render :edit
    end
  end

  def destroy
    if @restaurant.destroy
      flash[:success] = "Restaurant removed successfully"
      redirect_to restaurants_path
    end
  end

private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
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