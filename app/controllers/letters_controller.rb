class LettersController < ApplicationController

  respond_to :html

  def create
    if current_user.letters.create(params[:letter])
      flash[:notice] = 'Saved successfully !!'
    else
      flash[:error] = 'Oopss !! Error. Please try again.'
    end
    redirect_to root_path
  end

  def edit
    @letter = current_user.letter.find(params[:id])
  end

  def update
    if current_user.letter.find(params[:id]).update_attributes(params[:letter])
      flash[:notice] = 'updated successfully !!'
    else
      flash[:error] = 'Oopss !! Error. Please try again.'
    end
    redirect_to root_path
  end

end
