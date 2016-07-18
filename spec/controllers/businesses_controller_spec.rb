require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  it "makes index.json available" do
    get :index, :format => :json
    expect(response).to have_http_status(:ok)
  end

  xit "makes show.json available" do
    get "/businesses/1.json"
    expect(response).to have_http_status(:ok)
  end
end
