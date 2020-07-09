class Api::V1::UsersController < Api::V1::ApiController
  # TODO: Authorization
  before_action :set_user, except: :index
  include Picturable

  def index
    @users = User.all
    json_response( serialize( @users ) )
  end

  def show
    json_response( serialize( @user ) )
  end

  private 
  
  def set_user
    @user = User.find(params[:id])
  end
end
