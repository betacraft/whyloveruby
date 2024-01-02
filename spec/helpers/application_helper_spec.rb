require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe 'application helper' do
    # actual context: We realized just in time before RubyConfIndia2023 that due to Twitter API changes
    # we are unable to retrieve profile pictures for new twitter sign_ups through Cloudinary

    context 'get_profile_image for User' do
      it 'should render image tag with the twitter handle from active storage' do
        user = User.create(updated_at: Date.parse('2022-12-31').end_of_day)
        user.external_identities.create(handle: "my_twitter_handle", provider: "twitter", uid: "252152")

        image_path = Rails.root.join('app', 'assets', 'images', 'rails.png')
        user.twitter_identity.profile_image.attach(io: File.open(image_path), filename: 'my_twitter_handle.png')
    
        generated_url = helper.get_profile_image(user)
    
        expect(generated_url).to match("profile_image.*my_twitter_handle\.png")
      end
      it 'should render image tag with the github handle from active storage' do
        user = User.create(updated_at: Date.parse('2022-12-31').end_of_day)
        user.external_identities.create(handle: "my_github_handle", provider: "github", uid: "252150")

        image_path = Rails.root.join('app', 'assets', 'images', 'rails.png')
        user.github_identity.profile_image.attach(io: File.open(image_path), filename: 'my_github_handle.png')
    
        generated_url = helper.get_profile_image(user)
    
        expect(generated_url).to match("profile_image.*my_github_handle\.png")
      end
    end
  end
end
