class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :picture, :additional_pictures
end
