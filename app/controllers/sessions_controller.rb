class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = "Welcome back to Macro-Poster, #{user.name}!"
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Sorry that email or password is not correct'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "You have successfully logged out. Come back soon!"
    redirect_to root_path
  end
end
