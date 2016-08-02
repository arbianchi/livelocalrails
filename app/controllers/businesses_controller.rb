class BusinessesController < ApplicationController

  def yelp
    if params[:term]
      @businesses = NearbyBusinesses.for(
        {zip_code:  current_user.zip_code,
         term:      params[:term],
         page:      params[:page]
        }
      )
      render json: @businesses.to_json
    else
      render json: {message: "Please provide both a location, and search term."}, status: 400
    end
  end

  # def yelp
  #   @results = YelpGemWrapper.
  #     find_business({  location: current_user.zip_code,
  #                      term: @business.name})
  #   end
  #   @results.to_json
  # end

  # def yelp
  #   if params[:term]
  #     @businesses = NearbyBusinesses.for(
  #       {zip_code:  current_user.zip_code,
  #        term:      params[:term],
  #        page:      params[:page]
  #       }
  #     )
  #     render json: @businesses.to_json
  #   else
  #         render json: {message: "Please provide both a location, and search term."}, status: 400
  #   end
  # end



  def index
    @businesses = NearbyBusinesses.for(
     {zip_code: current_user.zip_code,
      page:     params[:page]}
    )
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
      render json: {message: "Business successfully added."}
    else
      render json: {message:"error"}
    end
  end

  def update
    @business = Business.find(params[:id])

    if @business.update(
      name:         params[:name],
      address:      params[:address],
      city:         params[:city],
      zip_code:     params[:zip_code],
      phone:        params[:phone],
      image_url:    params[:image_url],
      website_url:  params[:website_url],
    )
      render json: {message: "Business successfully updated."}
    else
      render json: {message: "error"}
    end
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to '/'
  end

  def find_business
    if params[:term]
      @businesses = NearbyBusinesses.for(
        {zip_code:  params[:location],
         term:      params[:term],
         page:      params[:page]
        }
      )
      render json: @businesses.to_json
    else
      render json: {message: "Please provide both a location, and search term."}, status: 400
    end
  end

  def claim
    @business = Business.find(params[:id])
    unless @business.owner_id.present?
      @business.owner_id = current_user.id
      @business.save!
      render json: {message: "Business successfully claimed."}
    else
      render json: {message: "This business has already been claimed."}, status: 401
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
