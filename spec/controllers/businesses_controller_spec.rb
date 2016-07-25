require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do

  let(:user) { create :user }
  let(:business) { create :business }

  def response_as_expected? response
    r = JSON.parse response.body
    (r.is_a? Array) &&
      (r.count == 20)
  end

  def set_auth_header user
        request.headers['HTTP_AUTHORIZATION'] = user.username
  end

  it "allows users to search near their zip code" do

    u = create :user, zip_code: "27701"
    set_auth_header u

    get :index, :format => :json
    expect(response).to have_http_status(:ok)

    expect(response_as_expected? response).
      to be_truthy
  end

  it "allows businesses to find themselves using location and a term" do
    u = user
    set_auth_header u
    yelp_id = "dames-chicken-and-waffles-durham"

    get :find_business, {
          :location => "317 W Main St, Durham, NC 27701",
          :term => "Dame's Chicken and Waffles", format: :json
        }

    expect(response).to have_http_status(:ok)

    r = JSON.parse response.body
    expect(r.first["yelp_id"]).to eq(yelp_id)

    expect(r.is_a? Array).
      to be_truthy

  end

  it "can claim businesses i.e. become owner" do
    u = user
    b = business
    set_auth_header u

    expect {
      post :claim, id: b.id
    }.to change { b.reload.owner_id }.to eq(u.id)
  end

  it "cannot claim businesses that are claimed" do
    u1 = user
    b = create :business, owner_id: u1.id
    u2 = user

    set_auth_header u2

    post :claim, id: b.id

    expect(b.reload.owner_id).to eq u1.id
    expect(response).to have_http_status("400")

  end




  it "can provide a yelp listing directly"

  xit "makes show available" do
    u = user

    set_auth_header u
    get :show, :format => :json, :id => 1

    expect(response).to have_http_status(:ok)
  end
end
