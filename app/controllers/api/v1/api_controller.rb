class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  # TODO: JWT Authentication - including Service Object for auth processing
end
