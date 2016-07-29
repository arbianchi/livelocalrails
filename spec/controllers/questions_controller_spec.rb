require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  include Helpers

  let(:user) { create :user }
  let(:business) { create :business }  
  let(:question) { create :question }
  let(:answer) { create :answer}

  describe "GET #index" do
    it "returns list of posted questions for a business" do

      sign_in user

      b = create :business, owner_id: user.id
      b.save!

      q1 = create :question, user_id: user.id, business_id: business.id
      q1.save!
      q2 = create :question, user_id: user.id, business_id: business.id
      q2.save!

      a1 = create :answer, answerer: user, question_id: q1.id
      a1.save!

      a2 = create :answer, answerer: user, question_id: q2.id
      a2.save!

      get :all, params:{ business_id: business.id }

      expect(response).to have_http_status(:ok)
      expect(parsed_response.class).to eq(Hash)

    end
  end

  describe "GET #all" do
    it "returns hash of posted questions => answers for a given business" do

      sign_in user

      b = create :business, owner_id: user.id
      q1 = create :question, user_id: user.id, business_id: business.id
      q2 = create :question, user_id: user.id, business_id: business.id

      b.save!
      q1.save!
      q2.save!

      get :index, params:{ business_id: business.id }

      expect(response).to have_http_status(:ok)
      expect( parsed_response.first["user_id"] ).to eq(user.id)
      expect(parsed_response.class).to eq(Array)
      expect(parsed_response.count).to eql(2)

    end
  end

  describe "POST #create" do
    it "posts question to business" do

      sign_in user
      b = create :business, owner_id: user.id
      b.save!

      expect { 
        post :create, params: 
    { user_id: user.id,
      business_id: user.business.id, }
      }.to change(Question, :count).by(1)

      expect(response).to have_http_status(:ok)
    end
  end
end
