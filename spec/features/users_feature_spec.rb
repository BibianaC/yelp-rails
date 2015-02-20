require 'rails_helper'

context 'user not signed in and on the homepage' do

  before do
    Restaurant.create(name: 'KFC')
  end

  it "should see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).to have_link('Sign in')
    expect(page).to have_link('Sign up')
  end

  it "should not see 'sign out' link" do
    visit('/')
    expect(page).not_to have_link('Sign out')
  end

  it "should not be able to add a restaurant" do
    visit('/')
    click_link('Add a restaurant')
    expect(current_path).to eq '/users/sign_in'
  end

  it "should not be able to add a review" do
    visit('/restaurants')
    click_link('Review KFC')
    expect(current_path).to eq '/users/sign_in'
  end

end

context "user signed in on the homepage" do
  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  it "should see 'sign out' link" do
    visit('/')
    expect(page).to have_link('Sign out')
  end

  it "should not see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end
end

context "user edit and delete restaurants" do

  before(:each) do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test1@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    visit '/restaurants'
    click_link('Add a restaurant')
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    click_link('Sign out')
  end

  it 'should not be able to delete a restaurant it did not create' do
    visit '/'
    click_link('Sign up')
    fill_in('Email', with: 'test2@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    click_link('Delete KFC')
    expect(page).to have_content('Error: You must be the author to delete a restaurant')
  end

  it 'should not be able to edit a restaurant it did not create' do
    visit '/'
    click_link('Sign up')
    fill_in('Email', with: 'test2@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    click_link('Edit KFC')
    expect(page).to have_content('Error: You must be the author to edit a restaurant')
  end

end

context 'Reviews' do

  before do
    user = User.new(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
    user.save
    user2 = User.new(email: 'test2@example.com', password: 'testtest', password_confirmation: 'testtest')
    user2.save
    user.restaurants.create name: 'KFC'
  end

  it 'should be able to leave one review per restaurant' do
    visit '/restaurants'
    click_link('Sign in')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    click_button('Log in')
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    visit '/restaurants'
    click_link 'Review KFC'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('You have already reviewed this restaurant')
  end

  it 'should be able to delete their own review' do
    visit '/restaurants'
    click_link('Sign in')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    click_button('Log in')
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    visit '/restaurants'
    click_link 'Delete Review'
    expect(page).to have_content('Review deleted successfully')
  end

  it 'should not be able to delete a review that was created by someone else' do
    visit '/restaurants'
    click_link('Sign in')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    click_button('Log in')
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link('Sign out')
    click_link('Sign in')
    fill_in('Email', with: 'test2@example.com')
    fill_in('Password', with: 'testtest')
    click_button('Log in')
    visit '/restaurants'
    click_link 'Delete Review'
    expect(page).to have_content('Error: You must be the author to delete a review')
  end

end








