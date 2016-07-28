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
    matches = Hash.new([]) 

    business_surveys.each do |biz_survey|
      Survey.column_names.each do |question|
        if (biz_survey.send(question) == true) && (user_survey.send(question) == true)
          matches[biz_survey.responder] = matches[biz_survey.responder] << question
        end
      end
    end
    matches 
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
