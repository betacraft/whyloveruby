module ApplicationHelper
  def get_twitter_image(user)
    image_tag image_for_twitter_handle(user), onerror: 'this.error=null;this.src="https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"'
  end


  private


  RubyConfIndia2023 = Date.parse('2023-08-26')


  def image_for_twitter_handle(user)
    if user.updated_at.after?(RubyConfIndia2023) && user.external_identities.find_by(provider: 'twitter')&.image.present?
      # this is a quick workaround for being unable to fetch images via Cloudinary for new twitter sign_ins due to Twitter API policy changes.
      # one problem with continuing to use this long term would be:
      #   - if a user changes their profile picture, the url saved on our model will become invalid
      #      we do have a fallback to default image in place, but it's not ideal
      #   - As an improvement, we can try to cache it (more like a permanent snapshot until their next login)
      #   - But a proper solution would be to fetch their current profile picture via a service or to periodically refresh it ourself
      user.external_identities.find_by(provider: 'twitter')&.image
    else
      user_handle = user.external_identities.find_by(provider: 'twitter')&.handle
      cloudinary_image_url(user_handle)
    end
  end


  def cloudinary_image_url(twitter_handle)
    "https://res.cloudinary.com/#{ENV['CLOUDINARY_HANDLE']}/image/twitter_name/#{twitter_handle}.jpg"
  end
end