//
//  OnboardingCell.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 27/09/22.
//

import UIKit

class OnboardingCell: UITableViewCell {

    @IBOutlet var weekSmallLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var weekLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var colorView: UIView!
    
    @IBOutlet weak var checkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


}
