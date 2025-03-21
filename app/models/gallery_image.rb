class GalleryImage < ApplicationRecord
  belongs_to :gallery
  # acts_as_list scope: :gallery
  mount_uploader :image, GalleryImageUploader

  after_create :set_orientation

  def set_orientation
    puts image
    puts image.width

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
end
