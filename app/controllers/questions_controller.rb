class QuestionsController < ApplicationController

  def show

    questions = Question.where(business_id: params["business_id"])

#     @all = {}

#     questions.each do |q|
#       if q.answers
#         @all[q.attributes] = q.answers
#       end
#     end
#     binding.pry

#     render json: @all.to_json

    all = []
    question = []
    answer = []

    questions.each do |q|
      if q.answers
        q.answers.each do |a|
          # all[q.to_json] = all[q.to_json] << q.answers.to_json
          question.push(q)
          answer.push(a)
        end
      end
    end
    all.push(questions)
    all.push(answer)
    render json: all 
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
