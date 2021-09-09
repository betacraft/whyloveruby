module ApplicationHelper
  def get_twitter_image(twitter_handle)
    "https://res.cloudinary.com/#{ENV['CLOUDINARY_HANDLE']}/image/twitter_name/#{twitter_handle}.jpg"
  end
end
