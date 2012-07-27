class HomeController < ApplicationController

  def index
    @letter = Letter.new
    @letters = Letter.order('(SELECT COUNT(*) FROM likes WHERE (letters.id=likes.letter_id)) DESC').includes([:likes, :user]).page(params[:page]).per(15)
    @recent_letters = Letter.limit(15).order('created_at DESC').includes(:user)
  end
end