class HomeController < ApplicationController

  def index
    @letter = Letter.new
    @letters = Letter.paginate(page: params[:page], per_page: 15, order: '(SELECT COUNT(*) FROM likes WHERE (letters.id=likes.letter_id)) DESC', include: [:likes, :user])
    @recent_letters = Letter.limit(5).order(:created_at).includes(:user)
  end

end
