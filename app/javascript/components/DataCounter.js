import React from "react"
import PropTypes from "prop-types"


const DataCounter = ({count}) => <div className="data-counter">We currently have {count} data samples.</div>

DataCounter.propTypes = {
  count: PropTypes.number.isRequired
}

export default DataCounter
