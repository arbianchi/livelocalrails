class QuestionsController < ApplicationController

  def index 

    @questions = Question.where(business_id: params["business_id"])

    respond_to do |format|
      format.json { render json: @questions.to_json}
      format.html { not_found }
    end
  end

  def create
    @question = Question.new( approved_params )

    if @question.save
      render json: {"message": "Question submitted."}
    else
      redirect_back fallback_location: '/'
    end
  end

  private

  def approved_params
    { user_id: current_user.id,
      business_id: params[:business_id],
      question_text: params[:question_text]
    }
  end
end
