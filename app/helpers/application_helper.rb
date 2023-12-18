module ApplicationHelper
  def get_twitter_image(user)
    image_tag image_for_twitter_handle(user), onerror: 'this.error=null;this.src="https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"'
  end


  private


  RubyConfIndia2023 = Date.parse('2023-08-26')


  def image_for_twitter_handle(user)
    if user.updated_at.after?(RubyConfIndia2023) && user.twitter_identity&.image.present?
      user.twitter_identity&.image
    elsif user.updated_at.after?(RubyConfIndia2023) && user.github_identity&.image.present?
      user.github_identity&.image 
    else
      user_handle = user.twitter_identity&.handle if user.twitter_identity.present?
      user_handle = user.github_identity&.handle if user.github_identity.present?
      cloudinary_image_url(user_handle)
    end
  end


  def cloudinary_image_url(twitter_handle)
    "https://res.cloudinary.com/#{ENV['CLOUDINARY_HANDLE']}/image/twitter_name/#{twitter_handle}.jpg"
  end
end