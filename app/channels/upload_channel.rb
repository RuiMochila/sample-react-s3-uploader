class UploadChannel < ApplicationCable::Channel
  def subscribed
    stream_from "upload"
  end
end
