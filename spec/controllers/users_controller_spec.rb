require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, password: "password") }


  it "renders show view" do
    u = user
    sign_in u

    get :show, id: u.id
    expect(response.code).to eq("200")
  end

end
