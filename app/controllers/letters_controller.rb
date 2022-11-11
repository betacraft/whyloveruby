class LettersController < ApplicationController

  respond_to :html
  before_action :authenticate_user!, :except => [:show]

  def create
    @letter = current_user.letters.new(letter_params)
    if @letter.save
      flash[:notice] = t('flash.saved_letter_successfully')
      redirect_to letter_path(@letter)
    else
      flash[:error] = 'Letter description cannot be empty. Try Again!'
      redirect_to root_path
    end
  end

  def show
    @recent_letters = Letter.limit(5).order('created_at DESC').includes(:user)
    @letter = Letter.find(params[:id])
  end

  def edit
    @recent_letters = Letter.limit(5).order('created_at DESC').includes(:user)
    @letter = current_user.letters.find(params[:id])
  end

  def update
    @letter = current_user.letters.find(params[:id])
    if @letter.update(letter_params)
      flash[:notice] = t('flash.updated_letter_successfully')
      redirect_to letter_path(@letter)
    else
      flash[:error] = 'Letter description cannot be empty. Try Again!'
    end
  end

  def like
    @letter = Letter.find(params[:id])
    if Like.create(letter_id: @letter.id, user_id: current_user.id)
      render :json => { success: true, message: 'Like saved..', likes: @letter.likes.count, id: @letter.id }
    else
      render :json => { success: false, message: 'Error saving like ..' }
    end
  end

  def destroy
    letter = current_user.letters.find(params[:id])
    letter.destroy!
    flash[:notice] = "Letter has been successfully deleted"

    redirect_to root_path
  end

  private

  def letter_params
    params.require(:letter).permit(:description, :image, :remove_image)
  end
end
