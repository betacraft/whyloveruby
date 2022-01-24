require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the HomeHelper. For example:
#
# describe HomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe HomeHelper, type: :helper do
  describe 'home helper' do
    context 'markdown method' do
      it 'should render markdown' do
        markdown_text = <<-HEREDOC
# Example heading

Example [link](https://example.org).
        HEREDOC
        rendered_markdown = helper.markdown markdown_text
        doc = Nokogiri::HTML rendered_markdown
        expect(doc.at_css('h1').content).to eq('Example heading')
        expect(doc.at_css('a').content).to eq('link')
        expect(doc.at_css('a')[:href]).to eq('https://example.org')
      end

      it 'should render code in markdown' do
        markdown_text = <<-HEREDOC
# Example heading

```ruby
puts 'foobar'
```
        HEREDOC
        rendered_markdown = helper.markdown markdown_text
        doc = Nokogiri::HTML rendered_markdown
        expect(doc.at_css('pre')).to be_truthy
      end
    end
  end
end
