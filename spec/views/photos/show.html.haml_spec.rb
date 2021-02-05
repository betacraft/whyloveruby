require 'rails_helper'

RSpec.describe "photos/show", type: :view do
  image= File.open("/home/shyam/betacraft/whyloveruby/public/forkme_right_red.png")
  before(:each) do
    @photo = assign(:photo, Photo.create!(
      image: image
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(photo_path(@photo))
  end
end
