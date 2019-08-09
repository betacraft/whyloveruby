namespace :modify_user_data do

  desc "Update user profile image"
  task update_user_profile_image: :environment do
    DEFAULT_IMAGE = "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"

    User.find_each do |user|
      response = TwitterWrapper.instance.get_current_profile_image(user.uid)
      if response[:status] == TwitterWrapper::STATUS[:valid_user]
        user.image = response[:payload]
      else response[:status] == TwitterWrapper::STATUS[:invalid_user]
        user.image = DEFAULT_IMAGE
        puts "#{ response[:payload] } (#{user.uid}) thus assigning default image to this user"
      end
      user.save!
    end
  end


  desc "Update user profile image URI scheme from \'http\' to \'https\'"
  task update_user_image_url_scheme_to_https: :environment do
    User.find_each { |user| user.update! image: user.image.gsub('http://', 'https://') }
  end
end