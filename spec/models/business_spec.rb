require 'rails_helper'

RSpec.describe Business, type: :model do

  it "creates a new business" do
    visit '/businesses/new'
    within("#session") do
      fill_in 'Business Name', :with => 'The Iron Yard'
      fill_in 'Password', :with => 'password'
      fill_in 'Password Confirmation', :with => 'password'
    end
    click_button 'Sign up'
    expect(page).to have_content 'Welcome!'
  end
end
