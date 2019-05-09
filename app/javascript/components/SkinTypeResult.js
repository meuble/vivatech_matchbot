import React from "react"
import PropTypes from "prop-types"

const SkinTypeResult = ({type, scent, colors}) => <div className="skin-type-result">
  <h2>{type}</h2>
  <div className="result-scent">
    <p>Ils ont préféré le parfum {scent}</p>
  </div>
  <div className="result-colors">
    {colors.map((color, index) => (
      <div className="color" key={color.color}>{color.color}: {color.count}</div>
    ))}
  </div>
</div>

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


