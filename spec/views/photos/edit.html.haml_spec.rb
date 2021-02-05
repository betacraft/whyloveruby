require 'rails_helper'

RSpec.describe "photos/edit", type: :view do
  image= File.open("public/forkme_right_red.png")
  before(:each) do
    @photo = assign(:photo, Photo.create!(
      image: image
    ))
  end

  it "renders the edit photo form" do
    render
    assert_select "form[action=?][method=?]", photo_path(@photo), "post" do
      assert_select "input[name=?]","photo[image]"
    end
  end
end
