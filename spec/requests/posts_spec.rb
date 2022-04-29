require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:each) { get user_posts_path(user_id: 6) }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('Blog')
    end

    describe 'GET /show' do
      Post.create(author_id: 1)
      before(:each) { get user_post_path(user_id: 1, id: 91) }
      it 'returns show page' do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
        expect(response.body).to include('Blog')
      end
    end
  end
end
