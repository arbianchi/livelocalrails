class ApiController < ApplicationController
  skip_before_action :authenticate_user!, only: [:register, :sign_in, :sign_up]

  before_action { request.format = :json }

  def sign_in
    user = User.find_by(username: params[:username])
    if user.valid_password?(params[:password])
      user.generate_token_for "front-end"
      auth_token = (user.token_for "front-end").nonce
      render json: {
               "token": auth_token,
               "message": "Sign in successful.",
                    "sign_in_count": user.sign_in_count,
             }
    else
      render status: 400, json: {"message": "error"}
    end
  end

  def sign_up
    # FIXME: need a way to log in an existing user (meaning what exactly?)
    @user = User.new(
      user_params
    )
    if @user.save
      @token = @user.generate_token_for "Angular Frontend"

      render json: {
               "token": @token,
                    "message": "Account successfully created.",
                    "sign_in_count": @user.sign_in_count
             }
    else
      errors = @user.errors.messages
      render status: 400, json: {"message": errors }
    end

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
