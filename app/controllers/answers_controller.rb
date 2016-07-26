class AnswersController < ApplicationController

  def index 

    @answers = Answer.where(question_id: params["question_id"])

    respond_to do |format|
      format.json { render json: @answers.to_json}
      format.html { not_found }
    end
  end

  def create
    @answer = Answer.new( approved_params )

    if @answer.save
      render json: {"message": "Answer submitted."}
    else
      redirect_back fallback_location: '/'
    end
  end

  private

  def approved_params
    { answerer: current_user,
      question_id: params["question_id"],
      answer_text: params["answer_text"]
    }
  end
end
