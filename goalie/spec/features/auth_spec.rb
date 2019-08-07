require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  background :each do
    visit new_user_path
  end

  scenario 'has a new user page' do 
    expect(page).to have_content("Sign Up")
  end

  feature 'signing up a user' do
    background :each do
      fill_in 'Username', with: 'jimmy'
      fill_in 'Password', with: 'password'
      click_button 'Sign Up'
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content('jimmy')
    end

  end
end

feature 'logging in' do

  scenario 'shows username on the homepage after login' do
    sign_up_jimmy
    click_button 'Log Out'

    visit new_session_path
    fill_in "Username", with: 'jimmy'
    fill_in "Password", with: 'password'
    click_button 'Log In'
    expect(page).to have_content('jimmy')
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state'

  scenario 'doesn\'t show username on the homepage after logout'

end