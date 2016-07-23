require 'rails_helper'

RSpec.describe SurveysController, type: :controller do

  let(:user) { create :user }

  let(:valid_params) { 
    {
        responder: user,
        hiring: false,
        glutFree: true,
        musicians: true,
        lgbt: true,
        localFood: false,
        minorityOwned: true,
        livWage: false,
        petFriend: true,
        artsCrafts: false,
        charNonprof: true,
        sustain: true,
        veganPeta: false,
      }
  }

  def set_auth_header user
    request.headers['HTTP_AUTHORIZATION'] = user.username
  end

  def parsed_response
    JSON.parse response.body
  end

  describe "POST #create" do
    it "creates a new survey" do

      set_auth_header user

      expect { Survey.create! valid_params }.to change(Survey, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "get #show" do
    it "returns an individual user or business survey" do

      set_auth_header user

      survey = Survey.create! valid_params

      get :show 
      # binding.pry
      
      expect(response).to have_http_status(:ok)
      expect( parsed_response["responder_id"] ).to eq(user.id)

    end
  end
end
