class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  enum priority:{row: 0, midium: 1, high: 2}
end