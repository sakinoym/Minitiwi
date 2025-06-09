require 'nkf'

class Post < ApplicationRecord
  belongs_to :user

  MAX_CONTENT_LENGTH = 255
  validates :content, presence: true, length: { maximum: MAX_CONTENT_LENGTH }
  validates :flag, presence: true, inclusion: {in: [1,2]}
  validate :does_not_include_prohibited_words

  has_many :favorites, dependent: :destroy

  private

  def does_not_include_prohibited_words
    normalized_content = NKF.nkf('-w --hiragana', content) # カタカナをひらがなに変換
    prohibited_words = ProhibitedWord.pluck(:word)
    prohibited_words.each do |ng_word|
      if normalized_content.include?(ng_word)
        errors.add(:base, "禁止ワードが含まれているため投稿できません")
        break
      end
    end
  end
end
