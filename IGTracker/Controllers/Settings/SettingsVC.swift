



import UIKit
import SafariServices
import MessageUI
import StoreKit

class SettingsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let settings: [CellElement] = [
        CellElement(type: .customCell, title: "Unlock all features".localized(), image: UIImage(named: "gift")!, action: .openURL, url: nil),
        CellElement(type: .defaultCell, title: "Log out".localized(), image: UIImage(named: "logOut")!, action: .openURL, url: nil),
        CellElement(type: .defaultCell, title: "Add new account".localized(), image: UIImage(named: "add")!, action: .openURL, url: nil),
        CellElement(type: .defaultCell, title: "Give feedback".localized(), image: UIImage(named: "feedback")!, action: .sendEmail, url: supportEmail),
        CellElement(type: .defaultCell, title: "Rate this app".localized(), image: UIImage(named: "rate")!, action: .rate, url: nil),
        CellElement(type: .defaultCell, title: "Invite friends".localized(), image: UIImage(named: "invite")!, action: .invite, url: nil),
        CellElement(type: .defaultCell, title: "Privacy policy".localized(), image: UIImage(named: "privacy")!, action: .openURL, url: privacyURL),
        CellElement(type: .defaultCell, title: "Terms of use".localized(), image: UIImage(named: "term")!, action: .openURL, url: termsURL),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        self.edgesForExtendedLayout = [ UIRectEdge.bottom ]
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    
}

// MARK: - extension: UITAbleViewDataSource
extension SettingsVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if settings[indexPath.row].type == .customCell {
            return 160
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = settings[indexPath.row]
        
        if setting.type == .customCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! SettingsTableViewCell
            cell.titleSettings.text = setting.title
            cell.giftImageView.image = setting.image
            cell.bottomCustomLabel.text = "*Ghost followers".localized()
            cell.setGradient()
            cell.giftImageView.rotate(degrees: 20)
            cell.setShadowIcon()
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! SettingsTableViewCell
            cell.titleSettings.text = setting.title
            cell.iconImageView.image = setting.image
            
            return cell
        }
    }
    
}



// MARK: - extension: UITableViewDelegate
extension SettingsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let setting = settings[indexPath.row]
        
        switch setting.action {
        case .openURL:
            if let url = URL(string: setting.url ?? "") {
                let vc = SFSafariViewController(url: url)
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true)
            }
            break
        case .sendEmail:
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([supportEmail])
                
                present(mail, animated: true)
            }
            break
        case .rate:
            guard let url = URL(string: rateURL) else { return }
            UIApplication.shared.open(url)
            break
        case .invite:
            share(message: "igtracker.pro", link: "itunes.apple.com")
        }
    }
    
    private func share(message: String, link: String) {
        if let link = NSURL(string: link) {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}


// MARK: - extension: MFMailComposeViewControllerDelegate
extension SettingsVC: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}



// MARK: - Model Cells
struct CellElement {
    
    let type: CellType
    let title: String
    let image: UIImage
    let action: ElementAction
    let url: String?
    
}

enum CellType {
    case defaultCell
    case customCell
}

enum ElementAction {
    case openURL
    case sendEmail
    case rate
    case invite
}
