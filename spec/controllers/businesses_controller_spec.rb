require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do

  def response_as_expected? response
    (response.is_a? Hash) &&
      (response["businesses"].count == 20)
  end

  it "allows users to search near their zip code" do

    u = FactoryGirl.create :user, zip_code: "27701"
    sign_in u

    get :index, :format => :json
    expect(response).to have_http_status(:ok)

    r = JSON.parse response.body

    expect(response_as_expected? r).
      to be_truthy
  end

  it "makes show.json available" do
    get :show, :format => :json, :id => 1
    expect(response).to have_http_status(:ok)
  end
end
