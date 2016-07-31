class AnswersController < ApplicationController

  def index 
    @answers = Answer.where(question_id: params["question_id"])

    render json: @answers.to_json
  end

  def create
    @answer = Answer.new( approved_params )

    if @answer.save
      render json: {"message": "Answer submitted."}
    end
  end

  private

  def approved_params
    params.permit!

    { answerer: current_user,
      question_id: params["answer_text"],
      answer_text: params["answer_text"]
    }
  end
end
