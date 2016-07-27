class SurveysController < ApplicationController

  def matches

    matches = {}

    business_surveys.each do |biz_survey|
      Survey.column_names.each do |question|
        if (biz_survey.send(question) == true) && (user_survey.send(question) == true)
          matches.push(biz_survey.responder_id)
        end
      end
    end

    @businesses_for_you = matches.map { |m| Business.find(m) }.uniq

    respond_to do |format|
      format.json { render json: @businesses_for_you.to_json}
      format.html { not_found }
    end
  end


  def create
    @survey = Survey.new( approved_params )
    if @survey.save
      render json: {"message": "Survey submitted."}
    else
      redirect_back fallback_location: '/'
    end
  end

  def show
    @survey = Survey.find_by(responder: current_user)
    respond_to do |format|
      format.json { render json: @survey.to_json}
      format.html { not_found }
    end
  end

  private

  def user_survey
    Survey.find_by(responder: current_user)
  end

  def business_surveys
    Survey.where(responder_type: "Business")
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
