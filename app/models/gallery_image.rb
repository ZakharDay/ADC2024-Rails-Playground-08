class GalleryImage < ApplicationRecord
  belongs_to :gallery
  # acts_as_list scope: :gallery
  mount_uploader :image, GalleryImageUploader

  default_scope { order(position: "ASC") }

  after_create :set_orientation
  after_create :set_position
  after_destroy :update_position

  def set_orientation
    if image.width > image.height
      self.orientation = "landscape"
    elsif image.width < image.height
      self.orientation = "portrait"
    elsif image.width == image.height
      self.orientation = "square"
    else
      puts "ERROR"
    end

    self.save!
  end

  def set_position
    self.position = self.gallery.gallery_images.count - 1
    self.save!
  end

  def update_position
    self.gallery.gallery_images.each_with_index do |gallery_image, index|
      gallery_image.position = index
      gallery_image.save!
    end
  end

end
