module ApplicationHelper
  def get_twitter_image(twitter_handle)
    image_tag "https://res.cloudinary.com/#{ENV['CLOUDINARY_HANDLE']}/image/twitter_name/#{twitter_handle}.jpg", onerror: 'this.error=null;this.src="https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"'
  end
end
