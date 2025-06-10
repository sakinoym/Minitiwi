# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

(1..10).each do |number|
  Post.create(content:'テスト' + number.to_s, user_id:1, flag:2)
end

(1..10).each do |number|
  Post.create(content:'テスト' + number.to_s, user_id:2, flag:2)
end

(1..10).each do |number|
  Post.create(content:'テスト' + number.to_s, user_id:3, flag:2)
end

(2..10).each do |number|
  User.create(name: 'テスト' + number.to_s, email: 'test' + number.to_s + '@mail.com', password: 'password')
end

require 'csv'

csv_path = Rails.root.join('db', 'fixtures', 'prohibited_words.csv')
CSV.foreach(csv_path, headers: true) do |row|
  ProhibitedWord.find_or_create_by(word: row['word'])
end