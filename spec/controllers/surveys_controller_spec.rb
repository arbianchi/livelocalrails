require 'rails_helper'

RSpec.describe SurveysController, type: :controller do

  include Helpers

  let(:user) { create :user }
  let(:business) { create :business}
  let(:survey) { create :survey }  

  describe "POST #create" do
    it "creates a new survey" do

      sign_in user

      s = attributes_for(:survey)

      expect {
        post :create, { **(s), responder: user }
      }.to change(Survey, :count).by(1)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "get #show" do
    it "returns an individual user or business survey" do

      sign_in user

      survey = create :survey, responder: user

      get :show 

      expect(response).to have_http_status(:ok)
      expect( parsed_response["responder_id"] ).to eq(user.id)

    end
  end

  describe "get #matches" do
    it "returns a of matching businesses and their 'true' criteria" do

      sign_in user

      user_survey = create :survey, responder: user
      user_survey.save!

      b1 = create :business
      b1.save!

      b2 = create :business
      b2.save!

      b3 = create :business
      b3.save!

      b1_survey = create :survey, responder: b1
      b1_survey.save!
      b2_survey = create :survey, responder: b2
      b2_survey.save!

      b3_survey = create :survey, responder: b3
      b3_survey.save!

      get :matches

      expect(response).to have_http_status(:ok)
      expect(parsed_response.class).to eq(Array)
    end
  end

end
