class ProhibitedWord < ApplicationRecord
  MAX_CONTENT_LENGTH = 255
  validates :word, presence: true, uniqueness: true, length: { maximum: MAX_CONTENT_LENGTH }
end
