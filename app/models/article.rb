class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, length: { maximum: 100 }
  validates :description, presence: true
  validates :category, presence: true
end

