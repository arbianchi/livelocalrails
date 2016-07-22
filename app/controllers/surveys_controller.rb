class SurveysController < ApplicationController

  def create
    @survey = Survey.new( approved_params )
    if @survey.save
      status :ok
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

  # def show
  #   @survey = survey.find(params[:id])
  #   respond_to do |format|
  #     format.json { render json: survey_mockup }
  #     format.html { not_found }
  #   end
  # end

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
