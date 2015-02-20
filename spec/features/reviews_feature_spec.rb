require 'rails_helper'

feature 'reviewing' do

 before do
    user = User.new(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
    user.save
    user2 = User.new(email: 'test2@example.com', password: 'testtest', password_confirmation: 'testtest')
    user2.save
    user.restaurants.create name: 'KFC'
  end

  scenario 'allows users to leave a review using a form' do
    sign_in('test@example.com', 'testtest')
    leave_review('so so', 3)
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'displays an average rating for all reviews' do
    sign_in('test@example.com', 'testtest')
    leave_review('So so', '3')
    click_link 'Sign out'
    sign_in('test2@example.com', 'testtest')
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end

end