class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    respond_with User.all
  end

  def show
    user = User.find(params[:id])
    respond_with user
  end
end
