module Response
  def json_response(object, status = :ok, options = {})
    render json: object, status: status, options: options
  end

  def serialize(resource)
    if serializer = serializer_for( resource.class.to_s.split('::').first )
      serializer.new( resource ).serialized_json
    else
      resource.to_json
    end
  end

  def answer_with(response, status = :ok, options = {})
    response.merge!( server_time: Time.now.to_i )
    json_response( response, status, options )
  end

  def serializer_for(class_name)
    return Module.const_get("#{class_name}Serializer")
  rescue NameError
    return nil
  end
end
