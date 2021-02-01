require 'rails_helper'

RSpec.describe "photos/index", type: :view do
  before(:each) do
    assign(:photos, [
      Photo.create!(
        image_data: "MyText"
      ),
      Photo.create!(
        image_data: "MyText"
      )
    ])
  end

  it "renders a list of photos" do
    render
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
