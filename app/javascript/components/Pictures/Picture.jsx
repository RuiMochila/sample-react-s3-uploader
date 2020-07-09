import React from 'react'

const Picture = (props) => {
  return (
    <div className="picture">
      <img src={props.attributes.thumbnail_url} />
    </div>
  )
}

export default Picture