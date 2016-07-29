class AnswersController < ApplicationController

  def index 
    @answers = Answer.where(question_id: params["question_id"])

    render json: @answers.to_json
  end

  def create
    @answer = Answer.new( approved_params )
    AnswersMailer.answers_mailer(current_user).deliver

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
