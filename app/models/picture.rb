class Picture < ApplicationRecord

  belongs_to :pictureable, polymorphic: true, optional: true
  default_scope { order( scope: :desc, created_at: :desc ) }
  after_destroy :destroy_file

  def url
    "#{ENV.fetch('BUCKET_URL')}/#{key}"
  end

  def thumbnail_url
    url.gsub("/originals/", "/thumbnails/")
  end

  private
  def destroy_file
    # TODO: Ask S3 to delete the file
  end
end
