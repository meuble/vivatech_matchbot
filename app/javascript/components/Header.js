import React from "react"

import HeaderImage from 'images/header_picture.png'
import HeaderLogo from 'images/header_logo.png'
import QRCode from 'images/QRCOSME360.png'
import Cosmetic from 'images/cosmetic360.jpeg'

const Header = () => {
  return <div>
    <img src={HeaderLogo} className="logo" />
    <img src={HeaderImage} className="picture" />
    <h1>Design & create your own lipstick</h1>
    <img src={QRCode} />
    <div className="footer">
      <img src={Cosmetic} className="vivatech mx-auto" />
      <p className="text-center">Résultats définitifs:<br />samedi 18 mai @16h</p>
    </div>
  </div>
}

export default Header