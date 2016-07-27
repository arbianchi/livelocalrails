require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  let(:user) { create(:user, password: "password") }
  it "can sign in to a user account" do
    u = user

    post :sign_in, {username: u.username, password: "password"}
    expect(response.code).to eq("200")
  end
end
