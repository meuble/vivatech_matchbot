import React from "react"
import PropTypes from "prop-types"

import ColorDiagram from "./ColorDiagram"

const SkinTypeResult = ({type, scent, colors}) => {
  return <div className="skin-type-result card">
    <div className="card-header">
      <h2>{type}</h2>
    </div>
    <div className="card-body">
      <div className="result-scent">
        <p>Ils ont préféré le parfum {scent}</p>
      </div>
      <ColorDiagram data={colors} />
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