require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  it "makes index.json available" do
    get :index, :format => :json
    expect(response).to have_http_status(:ok)
  end

  it "makes show.json available" do
    get :show, :format => :json, :id => 1
    expect(response).to have_http_status(:ok)
  end
end
