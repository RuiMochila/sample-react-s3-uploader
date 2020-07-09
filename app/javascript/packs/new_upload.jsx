import React from 'react'
import ReactDOM from 'react-dom'
import S3Uploader from '../components/S3Uploader/S3Uploader'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <S3Uploader />,
    document.getElementById('app_container'),
  )
})
