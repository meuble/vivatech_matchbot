import React from "react"

const Loader = () => {
  return <div className="spinner-border text-light"
    role="status"
    style={{position: "absolute", right: "1em", top: "1em"}}>
      <span className="sr-only">Loading...</span>
    </div>
}

export default Loader