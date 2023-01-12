//
//  SlideVC.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 28/09/22.
//

import UIKit

class SlideVC: UIViewController {
    
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    var num = 1
    
    var step: Onboarding = .first {
        didSet {
            
            UIView.transition(with: imageView, duration: 0.15, options: .transitionCrossDissolve, animations: {
                
                self.imageView.image = self.step.image
                self.titleLabel.text = self.step.title
                self.subTitleLabel.text = self.step.subTitle
            }
                              
            )}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientView(for: logInButton)
        
        bottomLabel.text = "We will never see or store your data".localized()
        logInButton.setTitle("Continue", for: .normal)
        configurePageControl()
        step = .first
    }
    
    // MARK: - PageControl
    
    func configurePageControl() {
        let allSteps = Onboarding.allCases
        self.pageControl.numberOfPages = allSteps.count
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor(red: 0.937, green: 0.149, blue: 0.616, alpha: 0.2)
        self.pageControl.currentPageIndicatorTintColor = UIColor(named: "pink")
        
    }
    
    
    // MARK: - Continue
    
    @IBAction func stepLogIn(_ sender: Any) {
        num += 1
        let screen = Onboarding(rawValue: num)
        
        switch screen {
        case .first:
            pageControl.currentPage = 0
            step = .first
            break
        case .second:
            pageControl.currentPage = 1
            step = .second
            break
        case .third:
            pageControl.currentPage = 2
            step = .third
            logInButton.setTitle("Log in with Instagram", for: .normal)
            break
        default:
            signedUser()
        }
        
    }
    
    private func signedUser() {
        if RealmDB.shared.getUser().isSubscribed {
            let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainView")
            UIApplication.shared.windows.first?.rootViewController = vc
        } else {
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "OnboardingVC")
            UIApplication.shared.windows.first?.rootViewController = vc
        }
    }
}




