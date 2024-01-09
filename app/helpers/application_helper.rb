module ApplicationHelper
  def get_profile_image(user)
    image_tag image_for_handle(user), onerror: 'this.error=null;this.src="https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"'
  end


  private

  def image_for_handle(user)
    if user.twitter_identity.present? && user.twitter_identity.profile_image.attached?
      url_for(user.twitter_identity.profile_image)
    elsif user.github_identity.present? && user.github_identity.profile_image.attached?
      url_for(user.github_identity.profile_image)
    else
      'https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png'
    end
  end
end
