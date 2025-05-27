class Post < ApplicationRecord
  belongs_to :user

  MAX_CONTENT_LENGTH = 255
  validates :content, presence: true, length: { maximum: MAX_CONTENT_LENGTH }

  has_many :favorites, dependent: :destroy
end
