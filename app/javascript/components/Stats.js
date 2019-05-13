import React from "react"
import PropTypes from "prop-types"

import Header from './Header';
import DataCounter from './DataCounter';
import SkinTypeResult from './SkinTypeResult';
import Loader from './Loader';

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
        { this.state.isFetching && <Loader isFetching={this.state.isFetching} /> }
        <DataCounter count={this.state.dataCount} />
        <div className="results card-group">
          {this.state.skinTypeResults.map((skinTypeResult) => (
            <SkinTypeResult
              key={skinTypeResult.title}
              type={skinTypeResult.title}
              scent={skinTypeResult.scent}
              colors={skinTypeResult.colors}
              brand={skinTypeResult.brand}
              age_group={skinTypeResult.age_group}
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
      age_group: PropTypes.string.is_required,
      brand: PropTypes.string.is_required,
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
