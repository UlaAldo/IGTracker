//
//  SettingsTableViewCell.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 13/09/22.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleSettings: UILabel!
    @IBOutlet var giftImageView: UIImageView!
    @IBOutlet var bottomCustomLabel: UILabel!
    @IBOutlet var defaultView: UIView!
    @IBOutlet var customView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = customView.bounds
        gradientLayer.colors = [
            UIColor(red: 0.2, green: 0.31, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.786, green: 0.222, blue: 0.967, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.121, blue: 0.477, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.52, blue: 0.204, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.741, blue: 0.158, alpha: 1).cgColor
        ]
        customView.layer.insertSublayer(gradientLayer, at: 0)
        customView.layer.masksToBounds = true
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.3)
        
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -2.29, b: 0.1, c: -2.25, d: -4.64, tx: 2.73, ty: 3.32))
        
    }
    
    func setShadowIcon() {
        giftImageView.layer.shadowRadius = 10
        giftImageView.layer.shadowOpacity = 0.7
        giftImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        giftImageView.layer.shadowColor = UIColor.systemPink.cgColor
        giftImageView.layer.masksToBounds = false
        
    }
}

extension UIView {

    func rotate(degrees: CGFloat) {
        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }
        self.transform =  CGAffineTransform(rotationAngle: degreesToRadians(degrees))
    }
}
