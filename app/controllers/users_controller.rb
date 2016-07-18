class UsersController < ApplicationController

  def test
    [{
      username => "username",
      email => "email@email.com",
    }]
  end

  def show
    @user = User.find params[:id]
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes(user_params)
      flash[:notice] = "Profile updated!"
      redirect_to @user
    else
      render :edit
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end


end
