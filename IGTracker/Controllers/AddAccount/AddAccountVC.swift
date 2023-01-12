//
//  AddAccountVC.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 23/09/22.
//

import UIKit

class AddAccountVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    lazy var blurredView: UIView = {
        let containerView = UIView()
        
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
        customBlurEffectView.frame = self.view.bounds
        
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
        dimmedView.frame = self.view.bounds
        
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
    }
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true)
    }
}


// MARK: - extension: UITAbleViewDataSource
extension AddAccountVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as! AddAccountCell
            cell.accountLabel.text = "Jenny_Wilson"
            cell.setCornerRadius()
            
            if indexPath.row == 0 {
                cell.addViewBorder()
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addAccount", for: indexPath) as! AddAccountCell
            
            return cell
        }
        
    }
}
    

// MARK: - extension: UITableViewDelegate
extension AddAccountVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

