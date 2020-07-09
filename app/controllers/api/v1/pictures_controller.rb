class Api::V1::PicturesController < Api::V1::ApiController

  def index
    pictures = Picture.all
    json_response( serialize( pictures ) )
  end

  def create
    picture = Picture.new(picture_params)

    if picture.save
      json_response( serialize( picture ) )
    else
      render json: { error: picture.errors.messages }, status: :unprocessable_entity
    end
  end

  private 

  def picture_params
    params.permit(:key)
  end
end
