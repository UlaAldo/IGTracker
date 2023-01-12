//
//  GradientColor.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 28/09/22.
//

import Foundation
import UIKit

func setGradientView(for view: UIView) {
   let gradientLayer = CAGradientLayer.init()
    
   gradientLayer.frame = view.bounds
   gradientLayer.colors = [
       UIColor(red: 0.2, green: 0.31, blue: 1, alpha: 1).cgColor,
       UIColor(red: 0.786, green: 0.222, blue: 0.967, alpha: 1).cgColor,
       UIColor(red: 1, green: 0.121, blue: 0.477, alpha: 1).cgColor,
       UIColor(red: 1, green: 0.52, blue: 0.204, alpha: 1).cgColor,
       UIColor(red: 1, green: 0.741, blue: 0.158, alpha: 1).cgColor
   ]
  
   gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
   gradientLayer.endPoint = CGPoint(x: 0.95, y: 0.3)
   
   gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(
       a: -2.29, b: 0.1, c: -2.25, d: -4.64, tx: 2.73, ty: 3.32)
   )
    gradientLayer.masksToBounds = true
  
    view.layer.insertSublayer(gradientLayer, at: 0)
    view.layer.masksToBounds = true
    
}

//func setShadowButton(with view: UIButton) {
//    view.layer.shadowColor = UIColor.systemPink.cgColor
//    view.layer.shadowOffset = CGSize(width: 0, height: 4)
//    view.layer.shadowRadius = 20
//    view.layer.shadowOpacity = 1
//    view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 17).cgPath
//    view.layer.cornerRadius = 17
//    view.clipsToBounds = true
//    view.layer.masksToBounds = false
//
//}

func setShadowButton(with view: UIButton) {
    let shadowLayer = CALayer.init()
    shadowLayer.frame = view.bounds
    view.clipsToBounds = true
            shadowLayer.shadowColor = UIColor.red.cgColor
            shadowLayer.shadowOpacity = 1
            shadowLayer.shadowRadius = 20
            shadowLayer.shadowPath = CGPath.init(rect: shadowLayer.bounds, transform: nil)
            shadowLayer.masksToBounds = false
//            gradientLayer.mask = shadowLayer

//            button.layer.insertSublayer(gradientLayer, at: 0)

//    view.layer.insertSublayer(shadowLayer, at: 1)
}


