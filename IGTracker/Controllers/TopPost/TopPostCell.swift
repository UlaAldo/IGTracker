//
//  TopPostCell.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 15/09/22.
//

import UIKit

class TopPostCell: UICollectionViewCell {
    
    @IBOutlet var numLabel: UILabel!
    @IBOutlet var photo: UIImageView!
    
    
    
    func commentsPost(num: Int) {
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "\(num) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]));
        text.append(NSAttributedString(string: "Comments".localized(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.34)]))
        numLabel.attributedText = text
    }
    
    func likedPost(num: Int) {
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "\(num) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]));
        text.append(NSAttributedString(string: "Likes".localized(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.34)]))
        numLabel.attributedText = text
    }
}
