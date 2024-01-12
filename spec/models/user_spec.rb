require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ActiveRecord associations' do
    it { should have_many(:letters) }
    it { should have_many(:likes) }
    it { should have_many(:external_identities) }
  end
end
