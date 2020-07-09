module Picturable
  extend ActiveSupport::Concern

  included do
    before_action :set_resource
    before_action :set_picture, only: :remove_picture
  end

  def pictures
    json_response( serialize( @resource.pictures ) )
  end

  def set_primary_picture
    @resource.set_primary_picture( picture_params )
    json_response( serialize( @resource.picture ) )
  end

  def remove_picture
    @resource.remove_picture( @picture.key )
    head :ok
  end

  private

  def picture_params
    params.permit(:key)
  end

  def set_resource
    @resource = instance_variable_get("@#{controller_name.singularize}")
  end

  def set_picture
    @picture = @resource.pictures.find_by( key: params[:picture_key] )
  end
end