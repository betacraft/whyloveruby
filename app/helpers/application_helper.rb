module ApplicationHelper
  def get_twitter_image(user)
    image_tag image_for_twitter_handle(user), onerror: 'this.error=null;this.src="https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"'
  end


  private

  def image_for_twitter_handle(user)
    if user.twitter_identity.present?
      url_for(user.twitter_identity.profile_image) if user.twitter_identity.profile_image.attached?
    elsif user.github_identity.present?
      url_for(user.github_identity.profile_image) if user.github_identity.profile_image.attached?
    end
  end
end