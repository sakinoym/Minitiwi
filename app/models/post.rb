class Post < ApplicationRecord
  belongs_to :user

  MAX_CONTENT_LENGTH = 255
  validates :content, presence: true, length: { maximum: MAX_CONTENT_LENGTH }
  validates :flag, presence: true, inclusion: {in: [1,2]}

  has_many :favorites, dependent: :destroy
end
