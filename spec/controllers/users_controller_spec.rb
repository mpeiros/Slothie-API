require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'when valid params are passed' do
      before(:each) do |test|
        post :create, params: { user: { 
                                  username: 'Example',
                                  email: 'example@test.com',
                                  password: 'password'
                                } 
                              } unless test.metadata[:has_request]
      end

      it 'responds with status code 200' do
        expect(response).to have_http_status 200
      end

      it 'creates a new user in the database', :has_request do
        expect { post(:create, params: { 
                                 user: { 
                                   username: 'Example',
                                   email: 'example@test.com',
                                   password: 'password'
                                 } 
                               }) }.to change(User, :count).by(1)
      end

      it 'assigns the newly created user as @user' do
        expect(assigns(:user)).to eq User.last
      end

      it 'returns the JSON representation of the user' do
        user = User.last
        expect(JSON.parse(response.body)).to eq 'id' => user.id, 
                                                'username' => user.username,
                                                'email' => user.email
      end
    end

    context 'when invalid params are passed' do
      before(:each) do |test|
        post :create, params: { user: { 
                                  username: '',
                                  email: '',
                                  password: '1234'
                                } 
                              } unless test.metadata[:has_request]
      end

      it 'responds with status code 400' do
        expect(response).to have_http_status 400
      end
    end
  end
end
