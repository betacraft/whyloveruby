class HomeController < ApplicationController

  def index
    @letter = Letter.new
    #@letters = Letter.paginate(page: params[:page], per_page: 15, order: '(SELECT COUNT(*) FROM likes WHERE (letters.id=likes.letter_id)) DESC', include: [:likes, :user])
    @letters = Letter.page(params[:page]).per(1)
    @recent_letters = Letter.limit(5).order('created_at DESC').includes(:user)
  end

end
