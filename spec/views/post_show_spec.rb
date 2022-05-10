require 'rails_helper'

RSpec.feature 'Tests for post-show page', type: :feature do
  background { visit new_user_session_path }
  scenario "if user can see post title of other users." do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'nuri@gmail.com', password: 'nurisecret')
    @post = Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    first(:link, href: user_path(@user2.id)).click
    first(:link, href: user_post_path(@user2.id, @post.id)).click
    expect(page).to have_content 'Testing with capybara'
  end

  scenario 'if user can see posts of other users text' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'nuri@gmail.com', password: 'nurisecret')
    @post = Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user2.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    first(:link, href: user_path(@user2.id)).click
    first(:link, href: user_post_path(@user2.id, @post.id)).click
    expect(page).to have_content "test for views"
    end

  scenario 'can see the first comments on a post.' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'nuri@gmail.com', password: 'nurisecret')
    @post = Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user2.id)
    @comment = Comment.create(text: ' testing comments', author_id: @user2.id, post_id: @post.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    first(:link, href: user_path(@user2.id)).click
    first(:link, href: user_post_path(@user2.id, @post.id)).click
    expect(page).to have_content 'testing comments'
  end

  scenario 'if user can see number of other users post comments' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'nuri@gmail.com', password: 'nurisecret')
    @post = Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user2.id)
    @coment1 = Comment.create(text: ' test comment 1', author_id: @user2.id,post_id: @post.id)
    @coment2 = Comment.create(text: ' test comment 2', author_id: @user2.id, post_id: @post.id)
    @coment3 = Comment.create(text: ' test comment 3', author_id: @user2.id, post_id: @post.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    first(:link, href: user_path(@user2.id)).click
    first(:link, href: user_post_path(@user2.id, @post.id)).click
    expect(page).to have_content 'Comments : 3'
  end

  scenario ' can see how many likes a post has.' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'nuri@gmail.com', password: 'nurisecret')
    @post = Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user2.id)
    @like = Like.create(author_id: @user2.id, post_id: @post.id)
    @like = Like.create(author_id: @user2.id, post_id: @post.id)
    @like = Like.create(author_id: @user2.id, post_id: @post.id)

    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    first(:link, href: user_path(@user2.id)).click
    first(:link, href: user_post_path(@user2.id, @post.id)).click
    expect(page).to have_content 'Likes : 3'
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view.' do
    @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
    @user2 = User.create(name: 'Nuri', email: 'nuri@gmail.com', password: 'nurisecret')
    @post = Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user2.id)

  within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    first(:link, href: user_path(@user2.id)).click
    first(:link, href: user_post_path(@user2.id, @post.id)).click
    
    expect(page.has_button?("~Like~")).to be true
  end
end
