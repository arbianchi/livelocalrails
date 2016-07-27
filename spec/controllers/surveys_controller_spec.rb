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
    it "returns an array of businesses that match the user survey on at least one attribute" do

      sign_in user

      user_survey = create :survey, responder: user
      user_survey.save!

      b = create :business
      b.save!

      10.times do
        FactoryGirl.create(:survey, responder: b)
      end

      get :matches

      expect(response).to have_http_status(:ok)
      expect(parsed_response.class).to eq(Array)
    end
  end

end
