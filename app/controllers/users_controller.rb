class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:sign_up, :sign_in ]

  def sign_up
    @user = User.new(
      user_params
    )
    if @user.save
      auth_token = set_token(user: user)
      render json: auth_token
    else
      render json: {"message":"error"}
    end
  end

  def sign_in
    user = User.find_by(username: params[:username])
    if user
      auth_token = set_token(user: user)
      render json: auth_token
    else
      render json: {"message":"error"}
    end
  end

def show
  @user = User.find params[:id]

  respond_to do |format|
    format.json {render json: user_data }
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

def edit
  @user = User.find(params[:id])
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

  def set_token ops={}
    username = User.find(ops[:user].id).username
    return {"token": username}
  end

  def user_data
    [{
      :id => 1,
      :username => "username",
      :first_name => "Joe",
      :last_name => "Shmo",
      :email => "email@email.com",
      :zipcode => "27701",
      :survey => []
    }]
  end

  def user_params
    {
      "username"    => params[:username],
      "email"       => params[:email],
      "password"    => params[:password],
      "zip_code"    => params[:zip_code]
    }

#    params.permit(
#      :username,
#      :email,
#      :password,
#      :first_name,
#      :last_name,
#      :zip_code
#    )
  end
end
