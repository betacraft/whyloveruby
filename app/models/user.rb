class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :trackable, :omniauthable, :database_authenticatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :remember_me, :name, :twitter_handle, :twitter_description, :twitter_description, :twitter_oauth, :website, :image

  has_many :letters
  has_many :likes

  class << self
    def find_for_twitter_oauth(auth)
      user = User.find_by_twitter_oauth(auth["credentials"]["token"])

      if user
        user
      else
        User.create(
          name: auth["info"]["name"],
          twitter_handle: auth["info"]["nickname"],
          twitter_description: auth["info"]["description"],
          website: (auth["info"]["urls"]["Website"] rescue nil),
          twitter_oauth: auth["credentials"]["token"],
          image: auth["info"]["image"]
        )
      end

    end

  end

end
