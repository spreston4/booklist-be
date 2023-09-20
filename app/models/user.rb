class User < ApplicationRecord
  has_secure_password
  has_one :wishlist, dependent: :destroy
  has_one :readlist, dependent: :destroy

  validates_presence_of :email
  validates_uniqueness_of :email
end
