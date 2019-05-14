import React from "react"

import HeaderImage from 'images/header_picture.png'
import HeaderLogo from 'images/header_logo.png'
import QRCode from 'images/qrcode.png'
import Vivatech from 'images/vivatech.jpg'

const Header = () => {
  return <div>
    <img src={HeaderLogo} className="logo" />
    <img src={HeaderImage} className="picture" />
    <h1>Design & create your own lipstick</h1>
    <img src={QRCode} />
    <div className="footer">
      <img src={Vivatech} className="vivatech mx-auto" />
      <p className="text-center">Résultats définitifs:<br />samedi 18 mai @16h</p>
    </div>
  </div>
}

export default Header