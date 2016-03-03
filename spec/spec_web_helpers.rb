def sign_up (email: 'test@test.test',
            password: 12345678,
            password_confirm: 12345678)
  visit '/restaurants'
  click_link 'Sign up'
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  fill_in :user_password_confirmation, with: password_confirm
  click_button 'Sign up'
end

def sign_in (email: 'test@test.test',
            password: 12345678)
  visit '/restaurants'
  click_link 'Sign in'
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_button 'Log in'
end

def sign_out
  visit '/restaurants'
  click_link 'Sign out'
end
