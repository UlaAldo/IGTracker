//
//  DefaultCells.swift




import UIKit

class DefaultCells: UITableViewCell {

    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nikLabel: UILabel!
    @IBOutlet var followButton: UIButton!
    
    var changeFollow: Bool = false
    
    
    // TODO:  Цвета вынести в Assets
    private let followColor = UIColor(named: "subbackground")
    private let unfollowColor = UIColor(named: "pink")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width/2
        followButton.layer.backgroundColor = unfollowColor?.cgColor
        followButton.setTitle("Follow".localized(), for: .normal)
    }

    
    
    @IBAction func changedFollow(_ sender: UIButton) {
        if sender.backgroundColor == unfollowColor {
            sender.backgroundColor = followColor
            sender.setTitle("Unfollow".localized(), for: .normal)
        }
        else {
            sender.backgroundColor = unfollowColor
            sender.setTitle("Follow".localized(), for: .normal)

        }
    }
}

