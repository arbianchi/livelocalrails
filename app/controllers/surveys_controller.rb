class SurveysController < ApplicationController

  def index 
    @matches = []
    @user_survey = Survey.find_by(responder: current_user)

    business_surveys = Survey.where(responder_type: "Business")

    business_surveys.each do |survey|
      s.attributes do |attr|
        if survey.attr == @user_survey.attr
          @matches.push(survey)
        end
      end

    respond_to do |format|
      format.json { render json: @matches.to_json}
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

  # def update
  #   @survey = survey.find(params[:id])

  #   if @survey.update(article_params)
  #     redirect_back fallback_location: '/'
  #   else
  #     redirect_back fallback_location: '/'
  #   end
  # end

  def show
    @survey = Survey.find_by(responder: current_user)
    respond_to do |format|
      format.json { render json: @survey.to_json}
      format.html { not_found }
    end
  end

  # def destroy
  #   @survey = survey.find(params[:id])
  #   @survey.destroy
  #   redirect_to '/'
  # end

  private

  def not_found
    redirect_to '/404'
  end

  def approved_params
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
