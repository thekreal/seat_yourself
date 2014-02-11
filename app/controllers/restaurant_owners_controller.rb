class RestaurantOwnersController < ApplicationController
  before_action :find_owner, except: [:new, :create]

  def show
  end

  def new
    @user = RestaurantOwner.new
  end

  def create
    @user = RestaurantOwner.new(owner_params)
    if @user.save
      signin @user
      flash[:success] = "Awesome, your account has been created, please create a new page for your restaurant"
      redirect_to new_restaurant_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(owner_params)
      signin @user
      flahs[:success] = "You account has been updated successfully"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      signout
      flash[:success] = "Sad to see you leave! Your restaurant page will be removed as well"
      redirect_to root_path
    end
  end

private

  def owner_params
    params.require(:restaurant_owner).permit(:name, :email, :password, :password_confirmation)
  end

  def find_owner
    @user = RestaurantOwner.find(params[:id])
  end

end