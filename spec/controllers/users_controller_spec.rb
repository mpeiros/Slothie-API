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
