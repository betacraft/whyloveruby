class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :trackable, :database_authenticatable, :omniauthable,
  omniauth_providers: [:github, :twitter]

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :remember_me, :name, :twitter_handle, :twitter_description, :twitter_description, :twitter_oauth, :website, :image

  has_many :letters
  has_many :likes
  has_many :external_identities

  class << self
    def find_for_twitter_oauth(auth)
      user = User.joins(:external_identities)
             .where(external_identities: { uid: auth.uid, provider: auth.provider })
             .first
      if user
        user.external_identities.find_by(provider: 'github').update(handle: auth.info.nickname, twitter_description: auth.info.description, 
                                        website: auth.info.urls.Website, oauth: auth.credentials.token, name: auth.info.name, image: auth.info.image)
        # TODO: handle exceptions later. For now, continue to sign in the user, regardless of whether image url is saved
        user
      else
        user = User.create
        user.external_identities.create(uid: auth.uid, provider: auth.provider, handle: auth.info.nickname, name: auth.info.name, image: auth.info.image,
                                        twitter_description: auth.info.description, website: auth.info.urls.Website, oauth: auth.credentials.token)
                                
      end
    end
    def from_omniauth(access_token)
      data = access_token.info 
      user = User.joins(:external_identities)
            .where(external_identities: { uid: access_token.uid, provider: access_token.provider })
            .first
      if user 
        user.external_identities.find_by(provider: 'github').update(handle: access_token.extra.raw_info.login, name: data['name'], email: data['email'], image: access_token.extra.raw_info.avatar_url)
        user
      else 
        user = User.create
        user.external_identities.create(uid: access_token.uid, provider: access_token.provider, handle: 
                                        access_token.extra.raw_info.login, image: access_token.extra.raw_info.avatar_url, name: data.name, email: data.email)
        user
      end
    end

  end  
end
