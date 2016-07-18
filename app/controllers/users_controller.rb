class UsersController < ApplicationController

  def test
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
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
