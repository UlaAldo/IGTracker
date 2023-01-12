



import UIKit

class DeletedLikes_CommentsVC: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    var deleted: DeletedPost?
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSegmentControl()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        segmentedControl.setTitle("Unliked photos".localized(), forSegmentAt: 0)
        segmentedControl.setTitle("Deleted comments".localized(), forSegmentAt: 1)
        fetch()
        
        self.edgesForExtendedLayout = [ UIRectEdge.bottom, UIRectEdge.top ]
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    
    @IBAction func choiceSegment(_ sender: Any) {
        tableView.reloadData()
    }
    
    
    private func fetch() {
        DetailsAPI.shared.getDeletedCommentsLikes { result in
            switch result {
            case .success(let deleted):
                self.deleted = deleted
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
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

// MARK: - extension: UITAbleViewDataSource
extension DeletedLikes_CommentsVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return deleted?.deletedLikes.count ?? 0
        default:
            return deleted?.deletedComments.count  ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return 100
        default:
            return 180
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "likes", for: indexPath) as! LikesCell
            let deletedLike = deleted!.deletedLikes[indexPath.row]
            cell.nameLabel.text = deletedLike.user.fullName
            
            if let url = deletedLike.user.avatar {
                cell.avatarImage.loadImageWithUrl(URL(string: url)!)
            } else {
                cell.avatarImage.image = UIImage(named: "noAva")
            }
            
            cell.photoImage.loadImageWithUrl(URL(string: deletedLike.post.image)!)
            cell.unlikedPost(time: deletedDate(date: deletedLike.dateDeleted))
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "comments", for: indexPath) as! CommentsCell
            let deletedComment = deleted!.deletedComments[indexPath.row]
            cell.nameLabel.text = deletedComment.user.fullName
            
            if let url = deletedComment.user.avatar {
                cell.avatarImage.loadImageWithUrl(URL(string: url)!)
            } else {
                cell.avatarImage.image = UIImage(named: "noAva")
            }
            
            cell.photoLabel.loadImageWithUrl(URL(string: deletedComment.post.image)!)
            cell.commentLabel.text = deletedComment.text
            cell.deletedComment(time: deletedDate(date: deletedComment.dateDeleted))
            
            return cell
        }
    }
}



// MARK: - extension: UITableViewDelegate
extension DeletedLikes_CommentsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - extension: DateFormatter
extension DeletedLikes_CommentsVC {
    
    
    func deletedDate(date:String) -> String {
        let data = DateFormatter()
        data.timeZone = NSTimeZone.local
        data.dateFormat = "dd.MM.yyyy HH:mm:ss"
        
        let now = data.string(from: NSDate() as Date)
        let startDate = data.date(from: date)
        let endDate = data.date(from: now)
        var _: NSCalendar = NSCalendar.current as NSCalendar
        
        
        let dateComponents = Calendar.current.dateComponents([ .weekOfMonth, .day , .hour , .minute , .second], from: startDate!, to: endDate!)
        
        let weeks = abs(dateComponents.weekOfMonth!)
        let days = abs(dateComponents.day!)
        let hours = abs(dateComponents.hour!)
        let min = abs(dateComponents.minute!)
        let sec = abs(dateComponents.second!)
        
        var timeAgo = ""
        
        
        if (sec > 0){
            if (sec > 1) {
                timeAgo = "\(sec) seconds ago".localized()
            } else {
                timeAgo = "\(sec) second ago".localized()
            }
        }
        
        if (min > 0){
            if (min > 1) {
                timeAgo = "\(min) minutes ago".localized()
            } else {
                timeAgo = "\(min) minute ago".localized()
            }
        }
        
        if(hours > 0){
            if (hours > 1) {
                timeAgo = "\(hours) hours ago".localized()
            } else {
                timeAgo = "\(hours) hour ago".localized()
            }
        }
        
        if (days > 0) {
            if (days > 1) {
                timeAgo = "\(days) days ago".localized()
            } else {
                timeAgo = "\(days) day ago".localized()
            }
        }
        
        if(weeks > 0){
            if (weeks > 1) {
                timeAgo = "\(weeks) weeks ago".localized()
            } else {
                timeAgo = "\(weeks) week ago".localized()
            }
        }
        
        return timeAgo
    }
}
