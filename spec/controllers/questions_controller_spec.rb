require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  include Helpers

  let(:user) { create :user }
  let(:business) { Business.create owner_id: user.id, name: 'fakebiz', phone: '9196800770'   }
  let(:question) { Question.create user_id: user.id, business_id: business.id, question_text: "Will this feature work correctly?" }

  def valid_params
    { user_id: user.id,
      business_id: user.business.id, 
      question_text: 'question?' 
    }
  end

  describe "GET #index" do
    xit "returns list of posted questions for a business" do

      set_auth_header user

      business.save!
      question.save!

      get :index, params:{ business_id: business.id }

      expect(response).to have_http_status(:ok)
      expect( parsed_response.first["user_id"] ).to eq(user.id)
      expect(parsed_response.class).to eq(Array)

    end
  end

  describe "POST #create" do
    it "posts question to business" do

      set_auth_header user
      business.save!
      post :create, params: valid_params

      expect { 
        post :create, params: valid_params
      }.to change(Question, :count).by(1)

      expect(response).to have_http_status(:ok)
    end
  end
end
