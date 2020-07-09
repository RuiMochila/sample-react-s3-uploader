class Api::V1::ProductsController < Api::V1::ApiController
  # TODO: Authorization
  before_action :set_product, except: :index
  include Picturable

  def index
    @products = Product.all
    json_response( serialize( @products ) )
  end

  def show
    json_response( serialize( @product ) )
  end

  private 
  
  def set_product
    @product = Product.find(params[:id])
  end
end
