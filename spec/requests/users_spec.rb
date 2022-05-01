require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('Blog')
    end

    describe 'GET #show' do
      before(:each) { get user_path(id: 6) }
      it 'return show page' do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
        expect(response.body).to include('Blog')
      end
    end
  end
end
