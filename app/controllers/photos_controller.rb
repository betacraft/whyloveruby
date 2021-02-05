class PhotosController < InheritedResources::Base

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.create(photo_params)
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo has successfully created.'}
        format.json { render :show, status: :created, location:@photo }
      else
        format.html {render :new}
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end



  private

    def photo_params
      params.require(:photo).permit(:image)
    end

end
