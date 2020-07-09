import React, { useState, useEffect, Fragment } from 'react'
import axios from 'axios'
import Picture from './Picture'

const Pictures  = () => {
  const [pictures, setPictures] = useState([]);

  useEffect(() => {
    axios.get('/api/v1/pictures.json')
    .then( resp => {
      setPictures(resp.data.data)
    } )
    .catch( resp => console.log(resp) )
  }, [pictures.length])

  const list = pictures.map( item => {
    return ( 
      <Picture 
        key={item.attributes.id} 
        attributes={item.attributes}
      />
    )
  })

  return (
    <Fragment>
      {list}
    </Fragment>
  )
}

export default Pictures