class QuestionsController < ApplicationController

  def all 

    questions = Question.where(business_id: params["business_id"])

    @all = {}

    questions.each do |q|
      if q.answers
        @all[q] = q.answers
      end
    end

    render json: @all.to_json
  end

  def index 
    @questions = Question.where(business_id: params["business_id"])
    render json: @questions.to_json
  end

  def create
    @question = Question.new( approved_params )
    QuestionsMailer.questions_mailer(User.first).deliver

    if @question.save
      render json: {"message": "Question submitted."}
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
