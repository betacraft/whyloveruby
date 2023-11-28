class ExternalIdentity < ActiveRecord::Base
  belongs_to :user

  validates :provider, uniqueness: { scope: :user_id, message: 'has already been taken for this user' }
  validates :provider, presence: true
  validates :uid, uniqueness: { scope: :provider, message: 'has already been taken for this provider' }
end
