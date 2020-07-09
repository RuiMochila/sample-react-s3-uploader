import React, { useState } from 'react'
import axios from 'axios'

import 'react-dropzone-uploader/dist/styles.css'
import Dropzone from 'react-dropzone-uploader'

const S3Uploader = () => {
  
  const [url, setUrl] = useState('');
  // TODO: Extract string. Play with react_on_rails next to experiment with SSR
  const baseUrl = 'https://rails-upload-demo.s3.eu-west-2.amazonaws.com/';

  const getUploadParams = async ({ file, meta }) => { 
    const { data: { post_url, get_url } } = await axios.get("/uploads/presigned_post?fileType=" + meta.type + "&filename=" + meta.name)
    setUrl(get_url)
    return { body: file, method: 'PUT', meta: { baseUrl }, url: post_url }
  }

  const handleChangeStatus = async ({ meta, file }, status) => { 
    console.log(status, meta, file)
    if ( status == 'done' ) {
      const endpoint = "/api/v1/pictures?key=" + encodeURIComponent(url.replace(baseUrl, ""))
      await axios.post(endpoint);
    }
  }

  const handleSubmit = (files, allFiles) => {
    console.log(files.map(f => f.meta))
    allFiles.forEach(f => f.remove())
  }

  return (
    <Dropzone
      maxFiles={1}
      getUploadParams={getUploadParams}
      onChangeStatus={handleChangeStatus}
      onSubmit={handleSubmit}
      accept="image/*"
    />
  )
}

export default S3Uploader