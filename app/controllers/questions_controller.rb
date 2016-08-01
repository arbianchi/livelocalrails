class QuestionsController < ApplicationController

  def show

    questions = Question.where(business_id: params["business_id"])

    all = {}

    questions.each do |q|
      if q.answers
        all[q.id] = {question: q, answers: q.answers}
      end
    end

    render json: all.to_json

  end

  def create
    @question = Question.new( approved_params )
    # QuestionsMailer.questions_mailer(current_user).deliver

    if @question.save
      render json: {"message": "Question submitted."}
    end
  end

  def destroy
    question = Question.find(params["question_id"])
    if question.destroy
      render json: {"message": "Question deleted." }
    end
  end

  private

  def approved_params
    params.permit!
    { user_id: current_user.id,
      business_id: params[:business_id],
      question_text: params[:question_text]
    }
  end
end
