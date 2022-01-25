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
  describe 'application heler' do
    context 'get_twitter_image method' do
      it 'should render image tag with the twitter handle' do
        twitter_handle = 'foobar'
        expect(helper.get_twitter_image(twitter_handle)).to match("#{twitter_handle}\.jpg")
      end
    end
  end
end
