class MembersController < ApplicationController
  before_action :find_user, except: [:new, :create]

  def show
    @user = current_user
  end

  def new
    @user = Member.new
  end

  def create
    @user = Member.new(member_params)
    if @user.save
      signin @user
      flash[:success] = "Thanks for signing up! You can start make reservations"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(member_params)
      signin @user
      flash[:success] = "You account has been updated successfully"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      signout
      flash[:success] = "Sad to see you leave!"
      redirect_to root_path
    end
  end

private

  def member_params
    params.require(:member).permit( :name, :email, :password, :password_confirmation )
  end

  def find_user
    @user = Member.find(params[:id])
  end

end
