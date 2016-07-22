require 'rails_helper'

RSpec.describe SurveysController, type: :controller do

  let(:user) { create :user }

  def set_auth_header user
    request.headers['HTTP_AUTHORIZATION'] = user.username
  end

  describe "POST #create" do
    it "creates a new Survey" do

      u = create :user
      set_auth_header u
      valid_params = { 
        responder: u,
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



      expect { Survey.create! valid_params }.to change(Survey, :count).by(1)

      expect(response).to have_http_status(:ok)
    end
  end

end
