//
//  TopViewersCell.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 14/09/22.
//

import UIKit

class TopViewersCell: UITableViewCell {

    @IBOutlet var followButton: UIButton!
    @IBOutlet var nikLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var numLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
