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

    context 'get_twitter_image for User who last signed in before RubyIndiaConf 2023' do
      it 'should render image tag with the twitter handle' do
        user = User.new(twitter_handle: 'my_twitter_handle', updated_at: Date.parse('2022-12-31').end_of_day)
        expect(helper.get_twitter_image(user)).to match("cloudinary.*my_twitter_handle\.jpg")
      end
    end
    context 'get_twitter_image for User who last signed in after RubyIndiaConf 2023' do
      it 'should render image tag with twitter handle (in the unlikely case, our User model does not contain the image url)' do
        user = User.new(twitter_handle: 'my_twitter_handle', updated_at: Date.parse('2024-01-01').end_of_day)
        expect(helper.get_twitter_image(user)).to match("cloudinary.*my_twitter_handle\.jpg")
      end
      it 'should render image tag using the URL saved on the User model' do
        user = User.new(
          twitter_handle: 'my_twitter_handle',
          image: 'https://pbs.twimg.com/profile_images/123456789/my_selfie.jpg',
          updated_at: Date.parse('2024-01-01').end_of_day
        )
        image_url = helper.get_twitter_image(user)
        expect(image_url).to_not match("my_twitter_handle\.jpg")
        expect(image_url).to match("my_selfie\.jpg")
      end
    end
  end
end
