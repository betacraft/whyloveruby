class Letter < ActiveRecord::Base

  belongs_to :user
  has_many :likes, dependent: :destroy
  validates_presence_of :description
  has_one_attached :image 
  def like_by?(user)
    likes.map(&:user_id).include?(user.id)
  end

end
