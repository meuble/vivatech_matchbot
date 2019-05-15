import React from "react"
import PropTypes from "prop-types"

import ColorDiagram from "./ColorDiagram"
import FranceMap from "./FranceMap"

const SkinTypeResult = ({type, count, scent, top_color, colors, age_group, brands, female_percentage, zipcode_percentage}) => {
  var zipcodes = zipcode_percentage.reduce((acc, zipcodeData) => {
    acc[zipcodeData.name] = zipcodeData.count;
    return acc;
  }, {})
  return <div className={type + " skin-type-result card text-center"}>
    <div className="card-body">
      <ColorDiagram data={colors} />
      <div className="row">
        <div className="col-3 type"></div>
        <div className="col stats">
          <div className="result-color">
            <p><span>N°1</span> {top_color}</p>
          </div>
          <div className="result-scent">
            <p><span>{scent}</span></p>
          </div>
          <div className="result-count">
            <p><span>{count} réponses</span></p>
          </div>
        </div>
      </div>
      <h2>Persona</h2>
      <div className="result-brands">
        <ul>
          {brands.map((brand) => {
            if (brand.name != null) {
              return <li key={brand.name}>{brand.count}% {brand.name}</li>
            }
          })}
        </ul>
      </div>
      <div className="row">
          <div className="col-3 my-auto align-middle result-gender">
            <p>{female_percentage}%</p>
          </div>       
          <div className="col">
            <FranceMap className="france" key={type + "FranceMap"} percentages={zipcodes}/>
          </div>   
          <div className="col-3 my-auto align-middle result-age">
            <p>{age_group} ans</p>
          </div>
      </div>
    </div>
  </div>
}

SkinTypeResult.proptypes = {
  type: PropTypes.string.is_required,
  count: PropTypes.number.is_required,
  scent: PropTypes.string.is_required,
  age_group: PropTypes.string.is_required,
  brands: PropTypes.arrayOf(
    PropTypes.shape({
      count: PropTypes.number.isRequired,
      name: PropTypes.string.isRequired
    }).isRequired
  ),
  top_color: PropTypes.string.is_required,
  colors: PropTypes.arrayOf(
    PropTypes.shape({
      color: PropTypes.string.isRequired,
      count: PropTypes.number.isRequired
    })
  ).isRequired
}

export default SkinTypeResult