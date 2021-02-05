require 'rails_helper'

RSpec.describe Letter, type: :model do
  describe 'ActiveModel validations' do
    it { should validate_presence_of(:description) }
    it { should allow_value('Ruby is awesome').for(:description) }
    it { should_not allow_value('').for(:description) }
  end
  describe 'ActiveRecord associations' do
    it { should have_many(:likes).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  describe 'methods in the class' do
    before(:all) do
      @user = create(:user)
      @letter = create(:letter)
    end

    context 'like_by?' do
      it 'should return false if user not liked' do
        expect(@letter.like_by?(@user)).to eq(false)
      end

      it 'should return true if user liked' do
        @letter.likes.create(user_id: @user.id)
        expect(@letter.like_by?(@user)).to eq(true)
      end
    end
  end
end
