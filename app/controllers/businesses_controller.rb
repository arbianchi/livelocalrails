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
      format.json

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

  def find_business
    results = yelp({location: params[:location],term: params[:term]})
    respond_to do |format|
      format.json { render json: results}
      format.html { not_found }
    end
  end

  private

  def not_found
    redirect_to '/404'
  end


  def yelp ops={}
    location = ops[:location] ||= 'Anchorage'
    term = ops[:term] ||= 'food'

    Yelp.client.search(location, item: term).businesses
  end

  def approved_params
    if current_user
      params[:location] = current_user.zip_code
    end
    params.permit(
     :location
    )
  end

  def zip_code
    27701
  end


  def business_mockup
    businesses_mockup.first
  end

  def businesses_mockup
    [{
      "name": "Billy's Gumbo and Fancy Hat Emporium",
      "owner": "Billy Joe",
      "description": "great restaurant",
      "phone": "2036876161",
      "zipcode": "27701",
      "business_url": "www.tiy.com",
      "image_url": "https://s3-media2.flash.yelpcdn.com/bphoto/o3w3EoATG8RX4w4FHrHpiw/ms.jpg",
      "categories": ["gumbo","hats"],
      "survey" => []
     },
     {
       "name": "Grits and Grand Galleria",
      "owner": "Marie Francis",
      "description": "fine food",
      "phone": "2036876162",
      "zipcode": "27701",
      "business_url": "www.google.com",
      "image_url": "https://s3-media2.flash.yelpcdn.com/bphoto/o3w3EoATG8RX4w4FHrHpiw/ms.jpg",
     "categories": ["grits","fancy pictures"],
     "survey" => []
    }]
  end
end
