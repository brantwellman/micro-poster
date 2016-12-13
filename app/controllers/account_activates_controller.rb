class AccountActivatesController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in(user)
      flash[:success] = "Your account has been activated! Welcome to Macro-Poster, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:danger] = "Sorry, that is an invalid activation link"
      redirect_to root_path
    end
  end
end
