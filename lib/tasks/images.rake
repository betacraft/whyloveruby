namespace :images do
  desc 'Load images from Cloudinary and store in Active Storage'
  task load_images: :environment do
    User.where('updated_at < ?', '2023-08-26').each do |user|
      cloudinary_url = "https://res.cloudinary.com/whyloveruby/image/twitter_name/#{user.twitter_identity.handle}.jpg"

      downloaded_image = URI.parse(cloudinary_url).open

      downloaded_image.rewind
      
      user.twitter_identity.profile_image.attach(io: downloaded_image, filename: "#{user.twitter_identity.handle}.jpg")

      puts "Image for #{user.twitter_identity.name} loaded and attached."
    end
  end
end
  