class Letter < ActiveRecord::Base

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_one_attached :image
  validates_presence_of :description
  validates :image,content_type: { in: %w[image/jpg image/png image/gif],
    message: 'must be a valid image format'}, size: {less_than: 5.megabytes, message: 'must be less than 5.megabytes' }
  def like_by?(user)
    likes.map(&:user_id).include?(user.id)
  end

end
