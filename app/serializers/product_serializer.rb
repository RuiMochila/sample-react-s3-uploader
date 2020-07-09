class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :user_id, :picture, :additional_pictures
end
