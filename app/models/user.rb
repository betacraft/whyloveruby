class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :trackable, :database_authenticatable, :omniauthable, :confirmable,
         omniauth_providers: [:twitter]

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :remember_me, :name, :twitter_handle, :twitter_description, :twitter_description, :twitter_oauth, :website, :image

  has_many :letters
  has_many :likes
  has_many :external_identities

  class << self
    def find_for_twitter_oauth(auth)
      user = User.where(uid: auth.uid, provider: auth.provider).first

      if user
        profile_image_url = auth["info"]["image"]
        user.update(image: profile_image_url) if profile_image_url.present?

        # TODO: handle exceptions later. For now, continue to sign in the user, regardless of whether image url is saved
        user
      else
        User.create(
          uid: auth["uid"],
          provider: auth["provider"],
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
