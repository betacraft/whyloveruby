class Like < ActiveRecord::Base

  belongs_to :user
  belongs_to :letter

  #validates_uniqueness_of :user_id, scope: :letter_id
  validates_presence_of :user_id, :letter_id

end
