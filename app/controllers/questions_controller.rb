class QuestionsController < ApplicationController

  def show
    all = get_all_questions_with_answers 
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

  def questions
    Question.where(business_id: params["business_id"])
  end

  def get_all_questions_with_answers

    all = []

    questions.each do |q|
      if q.answers
        all_answers = []
        q.answers.each do |a|
          answer = a.attributes
          answer["author"] = "#{a.answerer.username}"
          all_answers.push(answer)
        end
        question = q.attributes
        question["author"] = "#{q.user.username}"
        all.push({question: question, answers: all_answers})
      end
    end
    return all
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
