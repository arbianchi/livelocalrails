class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:sign_up, :sign_in ]

  def sign_up
    @user = User.new(
      user_params
    )
    if @user.save
      auth_token = set_token(user: @user)
      render json: auth_token.merge({"message": "Account successfully created."})
    else
      errors = @user.errors.messages
      render status: 400, json: {"message": errors }
    end
  end

  def sign_in
    user = User.find_by(username: params[:username])
    if user
      auth_token = set_token(user: user)
      render json: auth_token.merge({"message": "Sign in successful.", "sign_in_count": user.sign_in_count})
    else
      render status: 400, json: {"message": "error"}
    end
  end

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

  def set_token ops={}
    username = User.find(ops[:user].id).username
    return {"token": username}
  end

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
