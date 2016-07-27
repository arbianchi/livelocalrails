class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:sign_up, :sign_in ]

  def show
    @user = User.find params[:id]

    respond_to do |format|
      format.json {render json: @user }
      format.html { not_found }
    end
  end

  def index
    @users = User.all

    respond_to do |format|
      format.json {render json: user_data }
      format.html { not_found }
    end
  end

  def update
    @user = User.find params[:id]

    if @user.update_attributes(user_params)
      flash[:notice] = "Profile updated!"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    {
      "username"    => params[:username],
      "email"       => params[:email],
      "password"    => params[:password],
      "zip_code"    => params[:zip_code],
      "first_name"  => params[:first_name],
      "last_name"   => params[:last_name]
    }
  end
end
