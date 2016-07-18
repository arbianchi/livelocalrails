class UsersController < ApplicationController

  def test

  end

  def show
    @user = User.find params[:id]
  end

  def index
    @users = User.all
  end

end
