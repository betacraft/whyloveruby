require 'rails_helper'

RSpec.describe ExternalIdentity, type: :model do
  describe 'ActiveRecord associations' do
    it { should belong_to(:user) }
  end

  describe 'ActiveModel validations' do
    subject { create(:external_identity) } 
    it { should validate_presence_of(:provider) }
    it { should validate_uniqueness_of(:provider).scoped_to(:user_id).with_message('has already been taken for this user') }

    it { should validate_uniqueness_of(:uid).scoped_to(:provider).with_message('has already been taken for this provider') }
  end
end
