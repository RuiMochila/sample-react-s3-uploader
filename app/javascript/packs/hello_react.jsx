import React from 'react'
import ReactDOM from 'react-dom'

const Hello = props => {
  return (
    <h1>Hi {props.name}</h1>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello name="React" />,
    document.getElementById('app'),
  )
})
