class SurveysController < ApplicationController

  def matches
    @matches = get_matches
    render json: @matches.to_json
  end

  def create
    @survey = Survey.new( approved_params )
    if @survey.save!
      render json: {"message": "Survey submitted."}
    end
  end

  def show
    @survey = Survey.find_by(responder: current_user)
    render json: @survey.to_json
  end

  private

  def user_survey
    Survey.find_by(responder: current_user)
  end

  def business_surveys
    Survey.where(responder_type: "Business")
  end

  def get_matches
    match = [] 
    business_surveys.each do |biz_survey|
      match.push(biz_survey.responder.attributes.merge(biz_survey.attributes))
    end
    match

    # [
    #   {"id"=> "242",
    #    "name"=> "Beer Durham",
    #    "address"=> "404 Hunt St Ste 110",
    #    "phone"=> "9196800770",
    #    "survey" =>
    #                  ["veganPeta", "petFriend", "artsCrafts", "veganPeta", "petFriend", "artsCrafts", "veganPeta"]},
    #   {"id"=> "243",
    #    "name"=> "Wine Authorities - Wine Shop",
    #    "address"=> "2501 University Dr",
    #    "phone"=> "9194892884",
    #    "survey" =>
    #                  ["charNonprof", "veganPeta", "petFriend", "artsCrafts", "veganPeta", "petFriend", "artsCrafts", "charNonprof", "veganPeta"]},
    #   {"id"=> "244",
    #    "name"=> "Brandy Wine Cellars ",
    #    "address"=> "7011 Fayetteville Rd",
    #    "phone"=> "9195446358",
    #           "survey" =>
    #                  ["charNonprof", "petFriend", "artsCrafts", "veganPeta", "petFriend", "artsCrafts", "charNonprof", "veganPeta"]}
    # ]
  end

  def user_survey_mockup
      ["hiring", "musicians", "glutFree"]
  end

  def not_found
    redirect_to '/404'
  end

  def approved_params
    params.permit!
    { responder: current_user,
      hiring: params[:hiring],
      glutFree: params[:glutFree],
      musicians: params[:musicians],
      lgbt: params[:lgbt],
      localFood: params[:localFood],
      minorityOwned: params[:minorityOwned],
      livWage: params[:livWage],
      petFriend: params[:petFriend],
      artsCrafts: params[:artsCrafts],
      charNonprof: params[:charNonprof],
      sustain: params[:sustain],
      veganPeta: params[:veganPeta]
    }

  end
end
