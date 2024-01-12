namespace :images do
  desc 'Load images from Cloudinary and store in Active Storage'
  task load_images: :environment do
    saved_count = 0
    error_count = 0
    batch_count = 0
    User.where('updated_at < ?', '2023-08-26').find_in_batches(batch_size: 20) do |batch|
      batch.each do |user|
        cloudinary_url = "https://res.cloudinary.com/whyloveruby/image/twitter_name/#{user.twitter_identity.handle}.jpg"
        begin
          downloaded_image = URI.parse(cloudinary_url).open
          downloaded_image.rewind
          
          user.twitter_identity.profile_image.attach(io: downloaded_image, filename: "#{user.twitter_identity.handle}.jpg")

          if user.twitter_identity.profile_image.attached?
            saved_count += 1
          else
            error_count += 1
            puts "\nError saving profile image for user #{user.twitter_identity.name}:"
            puts user.twitter_identity.errors_full_message.to_sentence
          end
        rescue StandardError => e
          # Handling the exception
          error_count += 1
          puts "\nError downloading image for user #{user.id}: #{e.message}"
        end
      end
      batch_count += 1
      puts "\nBatch #{batch_count} completed..."
      puts "#{error_count} errors..."
      puts "#{saved_count} saved..."
    end
    puts "\n\nProcess Completed"
  end
end
