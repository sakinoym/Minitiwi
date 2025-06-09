require 'nkf'

class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  validate :does_not_include_prohibited_words

  has_many :posts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favorites
  has_many :likes, through: :favorites, source: :post

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def feed_posts
    Post.where(user_id: self.following_ids + [self.id], flag: 2)
  end

  def like(any_post)
    self.favorites.find_or_create_by(post_id: any_post.id)
  end

  def unlike(any_post)
    favorite = self.favorites.find_by(post_id: any_post.id)
    favorite.destroy if favorite
  end

  def liking?(any_post)
    self.likes.include?(any_post)
  end

  private

  def does_not_include_prohibited_words
    normalized_name = NKF.nkf('-w --hiragana', name)
    prohibited_words = ProhibitedWord.pluck(:word)
    prohibited_words.each do |ng_word|
      if normalized_name.include?(ng_word)
        errors.add(:name, "に禁止ワードが含まれているため登録できません")
        break
      end
    end
  end
end
