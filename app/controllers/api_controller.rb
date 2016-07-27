class ApiController < ApplicationController
  skip_before_action :authenticate_user!, only: [:register, :sign_in]

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

  def register
    # FIXME: need a way to log in an existing user (meaning what exactly?)
    @user = User.create!(
      email:    params[:email],
      password: params[:password]
    )
    @token = @user.generate_token_for "Angular Frontend"
  end

  def me
    @user     = current_user
    @birthday = Facebook.new(@user).get_birthday
  end
end
