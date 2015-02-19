require 'rails_helper'

context 'user not signed in and on the homepage' do
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
    expect(page).to have_content('Error: You must be the author to delete a review')
  end

end







