class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # flash message - welcome user
      # redirect user_path(user)
    else
      # flash error message
      flash.now[:danger] = 'Sorry that email or password is not correct'
      render 'new'
    end
  end

  def destroy
  end
end
