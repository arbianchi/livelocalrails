class BusinessesController < ApplicationController
  def index
    @businesses = yelp(approved_params)

    respond_to do |format|
      format.json { render json: @businesses.to_json }
      format.html { redirect_to '/404' }
    end
  end

 def show
   #@business = Business.find(params[:id])
   respond_to do |format|
     format.json { render json: business_mockup }
     format.html { not_found }
   end
  end

  def new
    @business = Business.new
    respond_to do |format|
      format.json { render json: :ok }
      format.html { not_found }
    end
  end

  def edit
    @business = Business.find(params[:id])
    respond_to do |format|
      format.json { render json: business_mockup }
      format.html { not_found }
    end
  end

  def create
    @business = Business.new
    if @business.save
      redirect_back fallback_location: '/'
    else
      redirect_back fallback_location: '/'
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

  private

  def not_found
    redirect_to '/404'
  end

  def yelp ops={}
    location = ops[:location] ||= 'Durham'
    term = ops[:term] ||= 'food'

    Yelp.client.search(location, item: term)
  end

  def approved_params
    params[:zip_code] ||= current_user.zip_code
    params.permit(
     :zip_code
    )
  end

  def business_mockup
    businesses_mockup.first
  end

  def businesses_mockup
    [{
      "name": "Billy's Gumbo and Fancy Hat Emporium",
      "owner": "Billy Joe",
      "description": "great restaurant"
      "phone": "2036876161"
      "zipcode": "27701"
      "business_url": "www.tiy.com" 
      "image_url": "https://s3-media2.flash.yelpcdn.com/bphoto/o3w3EoATG8RX4w4FHrHpiw/ms.jpg"
      "categories": ["gumbo","hats"]
      # "profile" => []
     # },
     # {
     # "name": "Grits and Grand Galleria",
     #  "owner": "Marie Francis",
     # "survey" => [],
     # "profile" => []
    }]
  end

  def zip_code
    27701
  end
end
