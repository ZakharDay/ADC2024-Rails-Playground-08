class GalleryImagesController < ApplicationController
  before_action :set_gallery_image, only: %i[ lower higher destroy ]

  def create
    @gallery = Gallery.find(params[:gallery_id])
    @gallery_image = @gallery.gallery_images.new(gallery_image_params)

    respond_to do |format|
      if @gallery_image.save
        format.turbo_stream
      end
    end
  end

  def lower
  end

  def higher
  end

  def destroy
    @gallery = @gallery_image.gallery
    @gallery_image.destroy
  end

  private

    def set_gallery_image
      @gallery_image = GalleryImage.find(params[:id])
    end

    def gallery_image_params
      params.require(:gallery_image).permit(:gallery_id, :image, :position)
    end

end
