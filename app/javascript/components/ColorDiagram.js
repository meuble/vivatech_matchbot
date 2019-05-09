import React from "react"
import PropTypes from "prop-types"
import { Bar } from 'react-chartjs-2';

const ColorDiagram = ({data}) => {
    var maxCount = data.map((e) => e.count).reduce((v, e) => v + e)
    return <Bar
      data={{
        labels: data.map((e) => e.color),
        datasets: [{
          data: data.map((e) => Math.floor(e.count * 100 / maxCount)),
          backgroundColor: [
            'rgba(255, 99, 132, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(255, 206, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(255, 159, 64, 0.2)'
          ]
        }]
      }} 
      height={200}
      options={{
        legend: {display: false},
        scales: {
          yAxes: [{
            ticks: {
              suggestedMin: 0,
              suggestedMax: 100
            }
          }]
        }
      }}
    />
}

ColorDiagram.proptypes = {
  data: PropTypes.arrayOf(
    PropTypes.shape({
      color: PropTypes.string.isRequired,
      count: PropTypes.number.isRequired
    })
  ).isRequired
}

export default ColorDiagram