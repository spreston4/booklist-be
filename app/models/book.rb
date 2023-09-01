class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :author }
  validates :author, presence: true
end
