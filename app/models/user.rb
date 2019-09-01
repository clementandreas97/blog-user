class User < ApplicationRecord
  # Password encryption
  has_secure_password
  validates_presence_of :name, :email, :password_digest
end
