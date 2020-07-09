module HasPictures
  extend ActiveSupport::Concern

  PRIMARY = 'primary_picture'
  SECONDARY = 'additional_picture'

  included do
    has_many :pictures, as: :pictureable, dependent: :destroy

    has_many :primary_picture_files,
          -> { where scope: PRIMARY }, 
          as: :pictureable,
          class_name: 'Picture'

    has_many :additional_picture_files,
          -> { where scope: SECONDARY }, 
          as: :pictureable,
          class_name: 'Picture'
  end

  module ClassMethods 
  end

  def picture
    primary_picture_files.first
  end

  def additional_pictures
    additional_picture_files
  end

  def picture=(new_picture)
    if new_picture.blank?
      picture.destroy
    else
      create_or_update_primary_picture( new_picture.key )
    end
  end

  def set_primary_picture(key)
    create_or_update_primary_picture( key )
  end

  def add_picture(key)
    ActiveRecord::Base.transaction do
      pictures.create_or_find_by( key: key ).update! scope: SECONDARY
      ( picture.nil? && additional_pictures.where.not( key: key ).any? ) ?
        additional_pictures.where.not(key: key).first.update!( scope: PRIMARY )
        : nil 
    end
  end

  def remove_picture(key)
    ActiveRecord::Base.transaction do
      pictures.find_by( key: key ).destroy!
      ( picture.nil? && additional_pictures.any? ) ?
        additional_pictures.first.update!( scope: PRIMARY )
        : nil
    end
  end

  private

  def create_or_update_primary_picture(key)
    ActiveRecord::Base.transaction do
      picture&.update! scope: SECONDARY
      pictures.create_or_find_by( key: key ).update! scope: PRIMARY
    end  
  end

end