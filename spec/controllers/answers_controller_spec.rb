require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  include Helpers

  let(:user) { create :user }
  let(:business) { FactoryGirl.create(:business) }
  let(:question) { Question.create user_id: user.id, business_id: business.id, question_text: "Will this feature work correctly?" }
  let(:answer) { Answer.create answerer: user, question_id: question.id, answer_text: "yes it will!" }

  describe "GET #index" do
    xit "returns list of answers for a given question" do

      set_auth_header user

      question.save!
      answer.save!

      get :index, params:{ business_id: question.id }

      expect(response).to have_http_status(:ok)
      expect( parsed_response.first["user_id"] ).to eq(user.id)
      expect(parsed_response.class).to eq(Array)

    end
  end

  describe "POST #create" do
    it "posts answer to question" do

      set_auth_header user

      business.save!
      question.save!
      
      expect { answer.save! }.to change(Answer , :count).by(1)
      expect(response).to have_http_status(:ok)
 binding.pry
    end
  end

end
