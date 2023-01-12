




import UIKit

class SecondCell: UICollectionViewCell {

    @IBOutlet var mediumLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    
    @IBOutlet var oneImage: UIImageView!
    @IBOutlet var twoImage: UIImageView!
    @IBOutlet var threeImage: UIImageView!
    
    @IBOutlet var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 0.114, green: 0.125, blue: 0.235, alpha: 1)
        bottomLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.39)
        transformImages(oneImage)
        transformImages(twoImage)
        transformImages(threeImage)
        setShadowIcon()
    }
    
    private func transformImages(_ image: UIImageView) {
        image.image = UIImage(named: "dog")
        
        image.layer.cornerRadius = image.frame.size.width/2
        image.borderWidth = 2
        image.borderColor = UIColor(red: 0.122, green: 0.141, blue: 0.31, alpha: 1)
        image.clipsToBounds = true
    }
    
    private func setShadowIcon() {
        iconImage.layer.shadowRadius = 30
        iconImage.layer.shadowOpacity = 1.0
        iconImage.layer.shadowOffset = CGSize(width: -5, height: 0)
        iconImage.layer.shadowColor = UIColor.systemPink.cgColor
        iconImage.layer.masksToBounds = false
    }
    
}
