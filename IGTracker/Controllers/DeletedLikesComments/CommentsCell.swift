//
//  CommentsCell.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 14/09/22.
//

import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var photoLabel: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width/2
    }

    func deletedComment(time: String) {
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Deleted the comment ".localized(), attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.498, green: 0.576, blue: 0.659, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]));
        text.append(NSAttributedString(string: "\(time)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.498, green: 0.576, blue: 0.659, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        descriptionLabel.attributedText = text
    }
    
}
