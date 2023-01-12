//
//  AddAccountCell.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 23/09/22.
//

import UIKit

class AddAccountCell: UITableViewCell {

    @IBOutlet var accountLabel: UILabel!
    @IBOutlet var cellView: UIView!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var circleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func addViewBorder(){
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor(red: 1, green: 0, blue: 0.96, alpha: 1).cgColor
    }
    
    func setCornerRadius() {
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width/2
    }
  
    @IBAction func exitedActionCell(_ sender: Any) {
        
    }
}



