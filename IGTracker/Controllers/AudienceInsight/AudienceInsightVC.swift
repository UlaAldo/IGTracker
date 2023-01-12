//
//  AudienceInsightVC.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 09/09/22.
//

import UIKit

class AudienceInsightVC: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSegmentControl()
   
        
        
    }
    
    private func createSegmentControl() {
        let textColor = [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.29)]
        let selectedColorText = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(textColor, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedColorText, for: .selected)
        segmentedControl.selectedSegmentTintColor = UIColor(red: 0.147, green: 0.162, blue: 0.296, alpha: 1)
        segmentedControl.backgroundColor = UIColor(red: 0.114, green: 0.125, blue: 0.235, alpha: 1)
       
    }

    
}

extension UIView {
    func addDashedCircle(from view: UIView) {
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = .clear
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.lineWidth = 2.0
        circleLayer.strokeColor =  UIColor.white.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineJoin = .round
        circleLayer.lineDashPattern = [6,7]
        layer.addSublayer(circleLayer)
    }
    
}
