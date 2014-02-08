class UsersController < ApplicationController
  before_action :action_verification, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      signin @user
      flash[:success] = "Account created successfully"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      signin @user
      flash[:success] = "Account updated successfully"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      signout
      flash[:success] = "Your account has being removed"
      redirect_to root_path
    end
  end

private

  def action_verification
    if !signed_in?
      flash[:warning] = "You are not signed in. Please signin first"
      redirect_to :signin
    elsif !current_user?(@user)
      flash[:warning] = "You are not authorized!"
      redirect_to current_user
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation )
  end

end
