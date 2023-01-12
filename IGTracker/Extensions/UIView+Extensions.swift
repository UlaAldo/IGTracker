import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func applyShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor

        layer.shadowOpacity = 1

        layer.shadowRadius = 7

        layer.shadowOffset = CGSize(width: 0, height: -7)
    }
}

public extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     alignment: Alignment = .fill,
                     distribution: Distribution = .fill,
                     spacing: CGFloat = 0.0,
                     layoutMargins: UIEdgeInsets? = nil) {
        
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        if let layoutMargins = layoutMargins {
            self.isLayoutMarginsRelativeArrangement = true
            self.layoutMargins = layoutMargins
        }
    }
    
}

public extension UILabel {
    
    convenience init(text: String? = nil,
                     textColor: UIColor = .white,
                     font: UIFont,
                     backgroundColor: UIColor = .clear,
                     textAlignment: NSTextAlignment,
                     lineBreakMode: NSLineBreakMode = .byWordWrapping,
                     numberOfLines: Int = 1) {
        
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.lineBreakMode = lineBreakMode
        self.numberOfLines = numberOfLines
    }
}

