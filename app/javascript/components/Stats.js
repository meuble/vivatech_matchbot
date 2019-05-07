import React from "react"
import PropTypes from "prop-types"

import DataCounter from './DataCounter';

class Stats extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      dataCount: props.dataCount || 0
    }    
  }
  
  render () {
    return (
      <React.Fragment>
        <DataCounter count={this.state.dataCount} />
      </React.Fragment>
    );
  }
}

Stats.propTypes = {
  dataCount: PropTypes.number.isRequired
}

export default Stats
