require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    let (:user_params) do
      { user: {
        username: 'jimmy',
        password: 'password'
      } }
    end
    context 'with valid params' do
      # post :create, params: user_params
      # jimmy = User.find_by(username: 'jimmy')

      it 'creates a new user with these params' do
        post :create, params: user_params
        jimmy = User.find_by(username: 'jimmy')
        expect(jimmy).not_to be_nil
      end

      it 'logs the user in' do
        post :create, params: user_params
        jimmy = User.find_by(username: 'jimmy')
        expect(session[:session_token]).to eq(jimmy.session_token)
      end

      it 'directs the user to their show page' do
        post :create, params: user_params
        jimmy = User.find_by(username: 'jimmy')
        expect(response).to redirect_to(user_url(jimmy))
      end
    end

  end

end
