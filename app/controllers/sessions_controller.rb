class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      # flash message - welcome user
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Sorry that email or password is not correct'
      render 'new'
    end
  end

  def destroy
  end
end
