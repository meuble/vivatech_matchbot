import React from "react"
import PropTypes from "prop-types"

import Header from './Header';
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
        <div className="container-fluid">
          { this.state.isFetching && <Loader isFetching={this.state.isFetching} /> }
          <h2>Tops produits par type de peau</h2>
          <div className="results card-group">
            {this.state.skinTypeResults.map((skinTypeResult) => (
              <SkinTypeResult
                key={skinTypeResult.title}
                type={skinTypeResult.title}
                count={skinTypeResult.count}
                scent={skinTypeResult.scent}
                colors={skinTypeResult.colors}
                top_color={skinTypeResult.top_color}
                brands={skinTypeResult.brands}
                age_group={skinTypeResult.age_group}
                female_percentage={skinTypeResult.female_percentage}
              />
            ))}
          </div>
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
