# frozen_string_literal: true

# User base class for product take home assignment
# Has only email and password attributes
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
end
