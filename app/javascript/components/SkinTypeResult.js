import React from "react"
import PropTypes from "prop-types"

import './SkinTypeResult.css'

const SkinTypeResult = ({type, scent, colors}) => {
  var maxCount = Math.max.apply(Math, colors.map((e) => e.count))
  maxCount = colors.map((e) => e.count).reduce((v, e) => v + e)
  return <div className="skin-type-result card">
    <div className="card-header">
      <h2>{type}</h2>
    </div>
    <div className="card-body">
      <div className="result-scent">
        <p>Ils ont préféré le parfum {scent}</p>
      </div>
      <ul className="result-colors" max={maxCount}>
        {colors.map((color, index) => (
          <li className={"color " + color.color} key={color.color} value={color.count} >
            <span>{color.color} ({Math.floor(color.count * 100 / maxCount)}%)</span>
          </li>
        ))}
      </ul>
    </div>
  </div>
}

SkinTypeResult.proptypes = {
  type: PropTypes.string.is_required,
  scent: PropTypes.string.is_required,
  colors: PropTypes.arrayOf(
    PropTypes.shape({
      color: PropTypes.string.isRequired,
      count: PropTypes.number.isRequired
    })
  ).isRequired
}

export default SkinTypeResult