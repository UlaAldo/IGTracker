//
//  OnboardingVC.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 27/09/22.
//

import UIKit
import SafariServices

class OnboardingVC: UIViewController {
    
    @IBOutlet var privacyButton: UIButton!
    @IBOutlet var termsButton: UIButton!
    @IBOutlet var restoreButton: UIButton!
    
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var selectedVariantIndex = 0
    
    let subscriptionVariants: [OnboardCell] = [
        OnboardCell(price: "23.99$/year".localized(), subPrice: "0,45$/week".localized()),
        OnboardCell(price: "4.99$/month".localized(), subPrice: "2.49$/week".localized()),
        OnboardCell(price: "1,25$/week".localized(), subPrice: "0,3$/day".localized())
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        privacyButton.setTitle("Privacy".localized(), for: .normal)
        restoreButton.setTitle("Restore".localized(), for: .normal)
        termsButton.setTitle("Terms".localized(), for: .normal)
        continueButton.setTitle("Continue".localized(), for: .normal)
        //        gradient(for: continueButton)
        setShadowButton(with: continueButton)
        setGradientView(for: continueButton)
        
    }
    
    func gradient(for button: UIButton) {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = button.frame
        gradientLayer.masksToBounds = true
        
        gradientLayer.colors = [UIColor(red: 0.2, green: 0.31, blue: 1, alpha: 1).cgColor,
                                UIColor(red: 0.786, green: 0.222, blue: 0.967, alpha: 1).cgColor,
                                UIColor(red: 1, green: 0.121, blue: 0.477, alpha: 1).cgColor,
                                UIColor(red: 1, green: 0.52, blue: 0.204, alpha: 1).cgColor,
                                UIColor(red: 1, green: 0.741, blue: 0.158, alpha: 1).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.3)
        //        gradientLayer.cornerRadius = 17
        
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(
            a: -2.29, b: 0.1, c: -2.25, d: -4.64, tx: 2.73, ty: 3.32)
        )
        button.layer.insertSublayer(gradientLayer, at: 0)
        
        //
        //        let shadowLayer = CALayer.init()
        //        shadowLayer.frame = gradientLayer.bounds
        //        shadowLayer.shadowColor = UIColor.red.cgColor
        //        shadowLayer.shadowOpacity = 1
        //        shadowLayer.shadowRadius = 20
        //        shadowLayer.shadowPath = CGPath.init(rect: shadowLayer.bounds, transform: nil)
        ////        shadowLayer.masksToBounds = false
        //        gradientLayer.mask = shadowLayer
        
        //        button.layer.insertSublayer(gradientLayer, at: 0)
        
        //        button.layer.insertSublayer(shadowLayer, below: gradientLayer)
        
        
    }
    
    
    // MARK: - Button Actions
    
    @IBAction func continueClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainView")
        UIApplication.shared.windows.first?.rootViewController = vc
    }
    
    @IBAction func exitedOut(_ sender: Any) {
        dismiss(animated: false)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func privacyClick(_ sender: Any) {
    }
    
    
    @IBAction func restoreClick(_ sender: Any) {
    }
    
    
    @IBAction func termsClick(_ sender: Any) {
        if let url = URL(string: termsURL) {
            let vc = SFSafariViewController(url: url)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
}

// MARK: - extension: UITAbleViewDataSource
extension OnboardingVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptionVariants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 120
        }
        else {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let variant = subscriptionVariants[indexPath.row]
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigCell", for: indexPath) as! OnboardingCell
            cell.yearLabel.text = variant.price
            cell.weekLabel.text = variant.subPrice
            cell.colorLabel.text = "Get 50% off for a yearly subscription".localized()
            setGradientView(for: cell.colorView)
            
            if selectedVariantIndex == indexPath.row {
                cell.checkImageView.image = UIImage(named: "check")
            } else {
                cell.checkImageView.image = UIImage(named: "unCheck")
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "smallCell", for: indexPath) as! OnboardingCell
            cell.monthLabel.text = variant.price
            cell.weekSmallLabel.text = variant.subPrice
            
            if selectedVariantIndex == indexPath.row {
                cell.checkImageView.image = UIImage(named: "check")
            } else {
                cell.checkImageView.image = UIImage(named: "unCheck")
            }
            return cell
        }
    }
    
}

// MARK: - extension: UITableViewDelegate
extension OnboardingVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
        
        selectedVariantIndex = indexPath.row
        tableView.reloadData()
        
    }
    
    
}


// MARK: - OnboardCell
struct OnboardCell {
    let price: String
    let subPrice: String
}
