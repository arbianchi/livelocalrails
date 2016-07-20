require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, password: "password") }

  it "can sign up for an account"

  it "can sign in to an account" do
    u = user

    post :sign_in, {username: u.username, password: "password"}
    expect(response.code).to eq("200")
  end
end
