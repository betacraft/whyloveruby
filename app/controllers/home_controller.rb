class HomeController < ApplicationController

  def index
    @letter = Letter.new
    @letters = Letter.all
  end

end
