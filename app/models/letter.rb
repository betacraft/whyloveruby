class Letter < ActiveRecord::Base

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  validates_presence_of :description
  validates :image, content_type: { in: %w[image/jpeg image/png image/gif], message: 'must be a valid image format' }, size: { less_than: 2.megabytes, message: 'must be less than 2.megabytes' }

  attr_accessor :remove_image

  after_save :purge_image, if: :remove_image
  
  def like_by?(user)
    likes.map(&:user_id).include?(user.id)
  end

  private
  
  def purge_image
    image.purge_later
  end

end
