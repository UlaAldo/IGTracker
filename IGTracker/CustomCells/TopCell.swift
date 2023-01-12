




import UIKit

class TopCell: UICollectionViewCell {

    @IBOutlet var topLabel: UILabel!
    @IBOutlet var mediumLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    
    @IBOutlet var iconImage: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 0.114, green: 0.125, blue: 0.235, alpha: 1)
        topLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
        mediumLabel.textColor = .white
        bottomLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.39)
        setShadowIcon()
    }
    
    private func setShadowIcon() {
        iconImage.layer.shadowRadius = 15
        iconImage.layer.shadowOpacity = 0.7
        iconImage.layer.shadowOffset = CGSize(width: -10, height: 5)
        iconImage.layer.shadowColor = UIColor.systemBlue.cgColor
        iconImage.layer.masksToBounds = false
        
    }
    
    func setBottomShadowCell() {
        layer.shadowColor = UIColor(red: 1, green: 0, blue: 0.96, alpha: 0.17).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 1
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 17).cgPath
        layer.cornerRadius = 17
        
    }
    
}
