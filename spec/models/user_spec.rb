require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    it '有効なユーザーはバリデーションが通る' do
      user = User.new(name: 'テストユーザー', email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end
  end  
end
