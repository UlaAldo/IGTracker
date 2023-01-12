//
//  TabBar.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 07/09/22.
//

import Foundation
import UIKit

class TabBar: UITabBarController {
    
    lazy var underView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.cornerRadius = 40
        tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = false
        
        self.tabBar.backgroundColor = UIColor(red: 0.118, green: 0.106, blue: 0.224, alpha: 0.60)
        
        self.viewControllers?[0].tabBarItem.title = NSLocalizedString("", comment: "")
        self.viewControllers?[1].tabBarItem.title = NSLocalizedString("", comment: "")
        
        self.viewControllers?[1].tabBarItem.image = UIImage(named: "account2")
        self.viewControllers?[0].tabBarItem.image = UIImage(named: "home2")
        
        self.view.insertSubview(underView, belowSubview: tabBar)

        underView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        underView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        underView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        setColorsIcon()
        addImageOnView()

        
//        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 10, vertical: 10)
//        self.viewControllers?[0].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 30);
//        self.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0);

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 80
        tabBar.frame.origin.y = view.frame.height - 100
        tabBar.frame.size.width = view.frame.width - 40
        tabBar.frame.origin.x = 20
        
        
    }
  
    
    // MARK: - Private functions
    private func addImageOnView() {
        let imageView = UIImageView(image: UIImage(named: "pinkShadow")!)
        imageView.layer.opacity = 1
        imageView.frame = CGRect(x: 0, y: -20, width: 150, height: 150)
        let imageView2 = UIImageView(image: UIImage(named: "rightShadow")!)
        imageView2.layer.opacity = 0.7
        imageView2.frame = CGRect(x: view.frame.width - 150, y: -20, width: 150, height: 150)
        
        self.underView.addSubview(imageView)
        self.underView.addSubview(imageView2)
    }
    
    private func setColorsIcon() {
        let appearance = UITabBarAppearance()
      
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 0.322, green: 0.31, blue: 0.404, alpha: 1)
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor(red: 0.322, green: 0.31, blue: 0.404, alpha: 1)
        ]
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white ]
        
        appearance.stackedItemPositioning = .automatic
        
        appearance.configureWithOpaqueBackground()

        appearance.backgroundColor = UIColor(red: 0.118, green: 0.106, blue: 0.224, alpha: 0.60)
        self.tabBar.standardAppearance = appearance
        
        
        
    }
    
}

@IBDesignable
class CustomTabBarItem: UITabBarItem {

    @IBInspectable var titlePosition: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            titlePositionAdjustment = UIOffset(horizontal: titlePosition.width, vertical: titlePosition.height)
        }
    }
    
    @IBInspectable var imageInset: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0) {
        didSet {
            imageInsets = UIEdgeInsets(top: imageInset.origin.x, left: imageInset.origin.y, bottom: imageInset.size.width, right: imageInset.size.height)
        }
    }
}
