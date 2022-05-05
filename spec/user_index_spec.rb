require 'rails_helper'

RSpec.feature 'Tests for user-index page', type: :feature do
  background { visit new_user_session_path }
  scenario 'Page should have username of other users' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'photo@gmail.com', password: 'nurisecret')
    @user3 = User.create(name: 'Rachid', email: 'kossi@gmail.com', password: 'rachidsecret')
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    expect(page).to have_content 'John'
    expect(page).to have_content 'Nuri'
    expect(page).to have_content 'Rachid'
  end

  scenario 'if user see posts of other users' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'photo@gmail.com', password: 'nurisecret')

    Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user2.id)
    Post.create(title: 'Again testing', text: 'if @user1 can see my posts :)', author_id: @user2.id)
    Post.create(title: 'Again test', text: 'if @user1 can see my posts ', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    expect(page).to have_content "Posts(#{@user2.posts.size})"
    expect(page).to have_content 'Posts(3)'
  end

  scenario 'Page should have username of other users' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
  within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    expect(page.has_link?("Sign Out")).to be true
  end
end