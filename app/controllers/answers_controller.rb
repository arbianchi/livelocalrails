class AnswersController < ApplicationController

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
      question_id: params["question_id"],
      answer_text: params["answer_text"]
    }
  end
end
