import React from "react"
import PropTypes from "prop-types"

import DataCounter from './DataCounter';
import SkinTypeResult from './SkinTypeResult';

const DATA_SERVICE_URL = window.location.origin + "/api/v1/data.json"

class Stats extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      dataCount: props.dataCount || 0,
      skinTypeResults: props.skinTypeResults || [],
      isFetching: false
    }    
  }
  
  componentDidMount() {
    this.timer = setInterval(() => this.fetchData(), 5000);
  }
  componentWillUnmount() {
    this.timer = null;
  }  
  
  fetchData = () => {
    this.setState({...this.state, isFetching: true})
    fetch(DATA_SERVICE_URL)
      .then(response => response.json())
      .then(result => this.setState({
        dataCount: result.dataCount, 
        skinTypeResults: result.skinTypeResults, 
        isFetching: false}
      ))
      .catch(e => console.log(e));
  }
  
  render () {
    return (
      <React.Fragment>
        <p>{this.state.isFetching ? 'Fetching data...' : ''}</p>
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
