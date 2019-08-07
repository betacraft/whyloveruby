class TwitterWrapper
  include Singleton
  STATUS = { valid_user: "valid_user", invalid_user: "invalid_user" }

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def get_current_profile_image(uid)
    begin
      image_url =  @client.user(uid.to_i).profile_image_url
      return { payload: image_url, status: STATUS[:valid_user] }
    rescue Twitter::Error::NotFound, Twitter::Error::Forbidden => e
      return { payload: e, status: STATUS[:invalid_user] }
    end
  end

end