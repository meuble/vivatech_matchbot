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
            'rgba(250, 121, 164, 1)', // #fa79a4 Rose Ancien
            'rgba(241, 77, 77, 1)', // #f14d4d Rose Corail
            'rgba(219, 0, 92, 1)', // #db005c Rose Gourmand
            'rgba(162, 54, 70, 1)', // #a23646 Rouge Cerise
            'rgba(198, 9, 36, 1)', // #c60924 Rouge Glamour
            'rgba(205, 56, 77, 1)', // #cd384d Rouge Romantique
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