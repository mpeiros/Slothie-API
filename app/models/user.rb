class User < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

  has_secure_password
  validates :password, length: { minimum: 6 }
end
