require 'rails_helper'

RSpec.describe "photos/new", type: :view do
  image= File.open("public/forkme_right_red.png")
  before(:each) do
    assign(:photo, Photo.new(
      image: image
    ))
  end

  it "renders new photo form" do
    render

    assert_select "form[action=?][method=?]", photos_path, "post" do

      assert_select "input[name=?]","photo[image]"
    end
  end
end
