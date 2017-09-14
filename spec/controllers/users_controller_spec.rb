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

      it 'does not add a user to the database', :has_request do
        expect { post(:create, params: { 
                                 user: { 
                                   username: '',
                                   email: '',
                                   password: '1234'
                                 } 
                               }) }.to change(User, :count).by(0)
      end

      it 'assigns the unsaved user as @user' do
        expect(assigns(:user)).to be_a_new User
      end

      it 'assigns the error messages to @errors' do
        expect(assigns(:errors)).to eq [ "Username can't be blank",
                                         "Email can't be blank",
                                         'Password is too short (minimum is 6 characters)' ]
      end

      it 'returns the JSON representation of the errors' do
        expect(JSON.parse(response.body)).to eq 'errors' => [
                                                  "Username can't be blank",
                                                  "Email can't be blank",
                                                  'Password is too short (minimum is 6 characters)'
                                                ]                                           
      end
    end
  end
end
