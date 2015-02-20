require 'rails_helper'

feature 'reviewing' do

 before do
    user = User.new(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
    user.save
    user.restaurants.create name: 'KFC'
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link('Sign in')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    click_button('Log in')
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end
end