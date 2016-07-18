require 'rails_helper'

RSpec.describe "the sign up process", :type => :feature do

  it "signs me up" do
    visit '/users/sign_up'
    within("#session") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
      fill_in 'Password Confirmation', :with => 'password'
    end
    click_button 'Sign up'
    expect(page).to have_content 'Welcome!'
  end
end

describe "the login process", :type => :feature do
  before :each do
    User.make(:email => 'user1@example.com', :password => 'password')
  end

  it "logs me in" do
    visit '/users/sign_in'
    within("#session") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Welcome!'
  end
end
