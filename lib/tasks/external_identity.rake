namespace :external_identity do
  desc "Create external identities from users"
  task :create_from_user => :environment do
    saved_count = 0
    error_count = 0
    batch_count = 0

    User.find_in_batches(batch_size: 20) do |batch|
      batch.each do |user|
        # Create an external identity for each user
        external_identity = user.external_identities.build(
          name: user.name.to_s,
          email: user.email.to_s,
          provider: user.provider.to_s,
          uid: user.uid.to_s,
          oauth: user.twitter_oauth.to_s,
          handle: user.twitter_handle.to_s,
          description: user.twitter_description.to_s,
          website: user.website.to_s,
          image: user.image.to_s
        )
        if external_identity.save
           saved_count = saved_count + 1
        else
          error_count = error_count + 1
          puts "\nError saving external identity for user #{user.slice(:id, :provider, :uid)}:"
          puts external_identity.errors.full_messages.to_sentence
        end
      end
      batch_count = batch_count + 1
      puts "\nBatch #{batch_count} completed..."
      puts "#{error_count} errors..."
      puts "#{saved_count} saved..."
    end
      puts "\n\nProcess Completed"
  end
end
