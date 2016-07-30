class BusinessesController < ApplicationController

  def yelp
    if @business = Business.find_by(id: params[:id])
      YelpGemWrapper.
      find_business({  location: @business.address,
                       term: @business.name})
    end
    @business.to_json
  end

  def index
    @businesses = NearbyBusinesses.for({zip_code: current_user.zip_code})
    @businesses = LocalScore.prepare(@businesses)
    render json: @businesses.to_json
  end

  def show
  end

  def create
    @business = Business.new(
      address:  params[:address],
      city:     params[:city],
      name:     params[:name],
      phone:    params[:phone],
      zip_code: params[:zip_code]
    )

    if @business.save
      render json: {"message":"Business successfully added."}
    else
      render json: {"message":"error"}
    end
  end

  def update
    @business = Business.find(params[:id])

    if @business.update(article_params)
      redirect_back fallback_location: '/'
    else
      redirect_back fallback_location: '/'
    end
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to '/'
  end

  def find_business
    @businesses = NearbyBusinesses.for({zip_code: params[:location],term: params[:term]})
    render json: @businesses.to_json
  end

  def claim
    @business = Business.find(params[:id])
    unless @business.owner_id.present?
      @business.owner_id = current_user.id
      @business.save!
      render json: {"message": "Business successfully claimed."}
    else
      render json: {"message": "This business has already been claimed."}, status: 401
    end
  end

  private

  def not_found
    redirect_to '/404'
  end

  def approved_params
    if current_user
      params[:location] = current_user.zip_code
    end
    params.permit(
     :location
    )
  end
end
