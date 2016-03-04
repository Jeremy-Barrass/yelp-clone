require 'rails_helper'

feature 'reviewing' do
  # before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
     visit '/'
     sign_up
     create_restaurant
     set_review
     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

  scenario 'user can only leave one review per restaurant' do
    visit '/'
    sign_up
    create_restaurant
    set_review
    another_review
    expect(page).to have_content('You have already reviewed this restaurant')
    expect(page).not_to have_content('epic')
  end

  scenario 'allows a review to be deleted' do
    visit '/'
    sign_up
    create_restaurant
    set_review
    click_link 'Delete review'
    expect(page).not_to have_content('so so')
    expect(page).to have_content('The review has been deleted')
  end

  scenario 'allows a review to be deleted by the creator only' do
    visit '/'
    sign_up
    create_restaurant
    set_review
    click_link 'Sign out'
    sign_up_other
    click_link 'Delete review'
    expect(page).to have_content('so so')
    expect(page).to have_content('The review can only be deleted by its creator')
  end

end
