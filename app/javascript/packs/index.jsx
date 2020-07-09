import React, { Fragment } from 'react'
import ReactDOM from 'react-dom'
import Pictures from '../components/Pictures/Pictures'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Fragment>
      <h2>Pictures</h2>
      <div className="pictures-grid">
        <Pictures />
      </div>
    </Fragment>,
    document.getElementById('app_container_index'),
  )
})
