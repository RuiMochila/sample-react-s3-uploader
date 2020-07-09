class UploadsController < ApplicationController
  skip_before_action :verify_authenticity_token
  include CableReady::Broadcaster

  def index
      
  end  
  
  def new
    
  end

  def presigned_post
    random_path = SecureRandom.uuid
    key = "uploads/originals/#{random_path}/#{filename_param}"
    s3 = Aws::S3::Resource.new(region: region)
    obj = s3.bucket(bucket_name).object(key)
    url = obj.presigned_url(:put, acl: 'public-read', content_type: file_type_param)
    get_url = "#{ENV.fetch('BUCKET_URL')}/#{key}"

    @upload = {
      post_url: url,
      get_url: get_url
    }.to_json

    json_response( @upload )
  end

  def status 
    components = src_key.split("/")
    key = components.pop
    escaped_key = CGI.escape(key).gsub("+", "%20")
    processed_key = (components + [escaped_key]).join("/")
    
    picture = Picture.find_by(key: src_key)
    head :ok unless picture # silent
    if picture.update(is_processed: true)
      cable_ready['upload'].insert_adjacent_html(
        selector: '#app_container',
        position: 'afterend',
        html: render_to_string(partial: 'picture', locals: {picture: picture})
      )
      cable_ready.broadcast
    end
    head :ok
  end

  private
  def filename_param
    params[:filename]
  end

  def file_type_param
    params[:fileType]
  end

  def bucket_name
    ENV.fetch('S3_BUCKET')
  end

  def region
    'eu-west-2'
  end

  def src_key
    params[:src_key]
  end
end