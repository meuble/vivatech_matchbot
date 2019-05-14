import React from "react"

import {DEPARTMENTS_DATA} from "./DepartmentData"

class FranceMap extends React.Component {
  constructor(props) {
    super(props)   
    this.state = {
      normalizedDepartments: this.normaliseData(this.aggregateIDF(this.props.percentages))
    }
  }
  
  // Normalize data between 0.3 and 1
  normaliseData(data) {
    var max = Object.keys(data).reduce((m, k) => m > data[k] ? m : data[k], 1)
    return Object.keys(data).reduce((r, k) => {
      r[k] = 0.3 + (data[k] + 0.0) * 0.7 / max
      return r
    }, {})
  }
  
  aggregateIDF(data) {
    var clone = Object.assign({}, data);
    var IDFdata = (data["75"] || 0)
      + (data["78"] || 0)
      + (data["91"] || 0)
      + (data["92"] || 0)
      + (data["93"] || 0)
      + (data["94"] || 0)
      + (data["95"] || 0)
      + (data["77"] || 0)
    clone["75"] = 
      clone["78"] = 
      clone["91"] = 
      clone["92"] = 
      clone["93"] = 
      clone["94"] = 
      clone["95"] = 
      clone["77"] = IDFdata
    return clone
  }

  getDepartmentStyle(name) {
    return this.state.normalizedDepartments[name] ? 
      {fill: "#FFD948", opacity: this.state.normalizedDepartments[name]}
      : {fill: "#CCC"}
  }
  
  render () {
    return (<svg
        xmlns="http://www.w3.org/2000/svg"
        xmlnsXlink="http://www.w3.org/1999/xlink"
        version="1.0"
        width="150"
        height="200"
        id="svg2"
        viewBox="0 0 500 550"
      >
      <defs id="defs4">
        <clipPath id="clipPath3345">
          <rect
            width="109"
            height="80"
            x="222"
            y="101"
            id="rect2227"
          />
        </clipPath>
      </defs>

      <g id="complete_map">
        <path
          d="M 432,545.25 L 432,475 L 496.25,433"
          style={{fill: "none", stroke:"#CCC", strokeWidth: "1.5"}}
          id="corsica_separating_line"
        />
        {DEPARTMENTS_DATA.map((e) => {
          return <path d={e.d} key={"department" + e.name} style={this.getDepartmentStyle(e.name)} />
        })}
      </g>
    </svg>);
  }
}

export default FranceMap