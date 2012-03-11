class LettersController < ApplicationController

  respond_to :html
  before_filter :authenticate_user!

  def create
    @letter = current_user.letters.new(params[:letter])
    if @letter.save
      flash[:notice] = 'Saved successfully !!'
      redirect_to letter_path(@letter)
    else
      flash[:error] = 'Oopss !! Error. Please try again.'
      redirect_to root_path
    end
  end

  def show
    @recent_letters = Letter.limit(5).order(:created_at).includes(:user)
    @letter = Letter.find(params[:id])
  end

  def edit
    @recent_letters = Letter.limit(5).order(:created_at).includes(:user)
    @letter = current_user.letters.find(params[:id])
  end

  def update
    @letter = current_user.letters.find(params[:id])
    if @letter.update_attributes(params[:letter])
      flash[:notice] = 'Updated Successfully !!'
    else
      flash[:error] = 'Oopss !! Error. Please try again.'
    end
    redirect_to letter_path(@letter)
  end

  def like
    @letter = Letter.find(params[:id])
    if Like.create(letter_id: @letter.id, user_id: current_user.id)
      render :json => { success: true, message: 'Like saved..', likes: @letter.likes.count, id: @letter.id }
    else
      render :json => { success: false, message: 'Error saving like ..' }
    end
  end

end
