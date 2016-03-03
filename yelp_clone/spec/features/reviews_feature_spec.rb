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

end
