require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  let(:user) { create(:user, password: "password") }
  it "can sign in to a user account" do
    u = user

    post :sign_in, {username: u.username, password: "password"}
    expect(response.code).to eq("200")
  end

  it "can sign up for an account" do
     u = attributes_for(:user)

     expect {
       post :sign_up, {**(u)}
     }.
       to change { User.count }.by 1

    expect(response.code).to eq("200")
  end

  it "can sign out of an account" do
    u = user

    post :sign_in, {username: u.username, password: "password"}
    expect(u.token_for "Angular Frontend").
      to be_truthy

    sign_in u   # needed to post the subsequent request...

    post :sign_out
    expect(u.token_for "Angular Frontend").
      to be_falsy

  end


end
