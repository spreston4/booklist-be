class Book < ApplicationRecord
  has_and_belongs_to_many :wishlists
  has_and_belongs_to_many :readlists
  validates :title, presence: true, uniqueness: { scope: :author }
  validates :author, presence: true
end
