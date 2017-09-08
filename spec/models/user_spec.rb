require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(username: 'username', email: 'email@test.com', password: 'tomtom123') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a username' do
      user.username = ''
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user.email = ''
      expect(user).to_not be_valid
    end

    it 'is not valid without a password of at least 6 characters' do
      user.password = 'tom1'
      expect(user).to_not be_valid
    end

    it 'is not valid without a unique username' do
      user.save
      another_user = User.new(username: 'username', email: 'tom@test.com', password: 'tomtom123')
      expect(another_user).to_not be_valid
    end

    it 'is not valid without a unique email' do
      user.save
      another_user = User.new(username: 'user', email: 'email@test.com', password: 'tomtom123')
      expect(another_user).to_not be_valid
    end
  end
end
