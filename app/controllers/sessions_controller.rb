class SessionsController < ApplicationController

  def new
  end

  def create
    auth = Authentication.new(params[:session])
    if auth.authenticate
      signin auth.user
      flash[:info] = "Welcome back"
      redirect_to root_path
    else
      flash[:error] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    signout
    flash[:info] = "See you again"
    redirect_to root_path
  end

end