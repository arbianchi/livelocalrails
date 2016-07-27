require 'rails_helper'
include Helpers

RSpec.describe RecommendationsController, type: :controller do
    let(:user) { create :user }
    let(:business) { create :business }

    it "can recommend a business as local" do
        u = user
        b = business

        sign_in u

        post :create, {business_id: b.id, value: "true"}

        r = Recommendation.find_by(
          user_id: u.id,
          business_id: b.id
        )
        expect(r.value).to eq("true")

        expect(response).to have_http_status(:ok)
    end


end
