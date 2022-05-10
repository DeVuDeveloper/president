require 'rails_helper'

RSpec.feature 'Tests for user-show page', type: :feature do
  background { visit new_user_session_path }

  scenario 'if click on user name redirecting to user/show page' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'photo@gmail.com', password: 'nurisecret')
    Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user2.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Nuri'
  end

  scenario 'if user in user/show page can see posts of other users' do
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
    first(:link, href: user_path(@user2.id)).click
    expect(page).to have_content 'Posts(3)'
  end

  scenario 'if every user can see Bio of other users' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'photo@gmail.com', password: 'nurisecret')
    Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    first(:link, href: user_path(@user2.id)).click
    expect(page).to have_content @user2.bio
  end

  scenario 'if current user can see recent posts of other users' do
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
    first(:link, href: user_path(@user2.id)).click
    expect(page).to have_content 'Testing with capybara'
  end

  scenario 'if every user can see link to all posts of users' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'photo@gmail.com', password: 'nurisecret')
    Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    first(:link, href: user_path(@user2.id)).click
    expect(page.has_link?('See all posts')).to be true
  end
end
