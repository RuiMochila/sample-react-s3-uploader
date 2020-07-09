class PictureSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :key, :url, :thumbnail_url

  belongs_to :pictureable, polymorphic: true
end
