require 'rails_helper'

RSpec.feature 'Tests for Log in', type: :feature do
  background { visit new_user_session_path }
  scenario 'if there is form login' do
    expect(page.has_field?('Email')).to be true
    expect(page.has_field?('Password')).to be true
    expect(page.has_button?('Log in')).to be true
  end

  context 'Form Submission' do
    scenario 'if can login without credentials' do
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    scenario 'if credentials are wrong' do
      within 'form' do
        fill_in 'Email', with: 'ajme@gmail.com'
        fill_in 'Password', with: '78901'
      end
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    scenario 'if credentials are right' do
      @user = User.create(name: 'John', email: 'drvu47@gmail.com', password: 'something')

      within 'form' do
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
      end
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
    end
  end
end
