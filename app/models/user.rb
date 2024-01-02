require 'open-uri'


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
  has_one :twitter_identity, -> { where provider: 'twitter' }, class_name: "ExternalIdentity"
  has_one :github_identity, -> { where provider: 'github' }, class_name: "ExternalIdentity"

  class << self
    def find_for_twitter_oauth(auth)
      user = User.joins(:external_identities)
             .where(external_identities: { uid: auth.uid, provider: auth.provider })
             .first
      if user
        user.update(name: auth.info.name)
        user.twitter_identity.update(
          handle: auth.info.nickname,
          description: auth.info.description,
          website: auth.info.urls.Website,
          oauth: auth.credentials.token,
          name: auth.info.name
        )
        user.update_profile_image(auth.info.image)
        user
      else
        user = User.create(name: auth.info.name)
        user.external_identities.create(
          uid: auth.uid,
          provider: auth.provider,
          handle: auth.info.nickname,
          name: auth.info.name,
          description: auth.info.description,
          website: auth.info.urls.Website,
          oauth: auth.credentials.token
        )
        user.update_profile_image(auth.info.image)
        user
      end
    end

    def find_for_github_oauth(auth)
      data = auth.info
      user = User.joins(:external_identities)
            .where(external_identities: { uid: auth.uid, provider: auth.provider })
            .first
      if user
        user.update(name: auth.info.name, email: auth.info.email)
        user.github_identity.update(
          handle: auth.extra.raw_info.login,
          name: data['name'],
          email: data['email']
        )
        user.update_profile_image(auth.extra.raw_info.avatar_url)
        user
      else
        user = User.create(name: auth.info.name, email: auth.info.email)
        user.external_identities.create(
          uid: auth.uid,
          provider: auth.provider,
          handle: auth.extra.raw_info.login,
          name: data.name,
          email: data.email
        )
        user.update_profile_image(auth.extra.raw_info.avatar_url)
        user
      end
    end
  end

  def update_profile_image(image_url)
    if twitter_identity
      twitter_identity.profile_image.attach(io: open_uri(image_url), filename: "#{twitter_identity.handle}.jpg") 
    elsif github_identity
      github_identity.profile_image.attach(io: open_uri(image_url), filename: "#{github_identity.handle}.jpg") 
    end
  end

  private

  def open_uri(url)
    URI.parse(url).open
  end
end
