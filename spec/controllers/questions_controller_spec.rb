require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:user) { create :user }

  let(:valid_params) {
    { user_id: user.id,
      business_id: 2,
      question_text: "Will this feature work correctly?" 
  }
  }

  def set_auth_header user
    request.headers['HTTP_AUTHORIZATION'] = user.username
  end

  def parsed_response
    JSON.parse response.body
  end

  describe "GET #index" do
    it "returns list of posted questions for a business" do

      set_auth_header user

      question = Question.create! valid_params
      business = FactoryGirl.build(:business)

      get :index

      expect(response).to have_http_status(:ok)
      expect( parsed_response["user_id"] ).to eq(user.id)
      expect(parsed_response.class).to eq(Array)

    end
  end

  describe "POST #create" do
    it "posts question to business" do

      set_auth_header user

      expect { Question.create! valid_params }.to change(Question, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
  end
end
