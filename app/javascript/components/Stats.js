import React from "react"
import PropTypes from "prop-types"

import DataCounter from './DataCounter';
import SkinTypeResult from './SkinTypeResult';

class Stats extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      dataCount: props.dataCount || 0,
      skinTypeResults: props.skinTypeResults || [],
    }    
  }
  
  render () {
    return (
      <React.Fragment>
        <DataCounter count={this.state.dataCount} />
        <div className="results">
          {this.state.skinTypeResults.map((skinTypeResult) => (
            <SkinTypeResult
              key={skinTypeResult.title}
              type={skinTypeResult.title}
              scent={skinTypeResult.scent}
              colors={skinTypeResult.colors}
            />
          ))}
        </div>
      </React.Fragment>
    );
  }
}

Stats.propTypes = {
  dataCount: PropTypes.number.isRequired,
  skinTypeResults: PropTypes.arrayOf(
    PropTypes.shape({
      title: PropTypes.string.isRequired,
      scent: PropTypes.string.isRequired,
      colors: PropTypes.arrayOf(
        PropTypes.shape({
          color: PropTypes.string.isRequired,
          count: PropTypes.number.isRequired
        })
      ).isRequired,
    })
  )
}

export default Stats
