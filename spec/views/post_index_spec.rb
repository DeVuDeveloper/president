
RSpec.describe 'Testing posts views', type: :feature do
  describe 'oo' do
    before(:each) do
      @user1 = User.create(name: 'John', email: 'john@gmail.com', password: 'johnsecret')
      @user2 = User.create(name: 'Nuri', email: 'nuri@gmail.com', password: 'nurisecret')
      @post = Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user1.id)
      @post = Post.create(title: 'Testing post-index page', text: 'test for views post-index page', author_id: @user1.id)
      @coment1 = Comment.create(text: ' test comment 1', author_id: @user1.id,post_id: @post.id)
      @coment2 = Comment.create(text: ' test comment 2', author_id: @user2.id, post_id: @post.id)
      @coment3 = Comment.create(text: ' test comment 3', author_id: @user2.id, post_id: @post.id)
      @like = Like.create(author_id: @user2.id, post_id: @post.id)
      @like = Like.create(author_id: @user1.id, post_id: @post.id)
      @like = Like.create(author_id: @user2.id, post_id: @post.id)
      visit user_session_path
      fill_in 'Email',	with: 'john@gmail.com'
      fill_in 'Password',	with: 'johnsecret'
      click_button 'Log in'
      visit user_posts_path user_id: @user1.id
    end 

    it "if user can see own name" do
      expect(page).to have_content 'John'
    end

    it 'if user can see number of posts.' do
      expect(page).to have_content 'Posts(2)'
    end

    it "if user can see post title" do
      expect(page).to have_content 'Testing with capybara'
    end

    it "if user can see post text" do
      expect(page).to have_content 'test for views'
    end

    it 'if user can see comments text' do
      expect(page).to have_content 'Comments:'
      expect(page).to have_content 'Nuri: test comment 3 Nuri: test comment 2 John: test comment 1'
    end

    it 'if user can see posts count' do
      expect(page).to have_content 'Comments: 3'
    end

    it 'if user can see likes count' do
      expect(page).to have_content 'Likes: 3'
    end

    it 'if page has link' do
      expect(page.has_link?("All Users")).to be true
    end
 end
end