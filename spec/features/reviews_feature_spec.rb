require 'rails_helper'

feature 'reviewing' do

 before do
    user = User.new(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
    user.save
    user.restaurants.create name: 'KFC'
  end

  scenario 'allows users to leave a review using a form' do
    sign_in('test@example.com', 'testtest')
    leave_review('so so', 3)
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end
end