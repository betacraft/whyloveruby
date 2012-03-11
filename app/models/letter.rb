class Letter < ActiveRecord::Base

  belongs_to :user
  has_many :likes

  def like_by?(user)
    likes.map(&:user_id).include?(user.id)
  end

end
