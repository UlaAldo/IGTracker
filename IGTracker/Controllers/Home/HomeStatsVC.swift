



import UIKit


class HomeStatsVC: UIViewController {
    
    @IBOutlet var followersCount: UILabel!
    @IBOutlet var postsCount: UILabel!
    @IBOutlet var followingsCount: UILabel!
    @IBOutlet var addAccountButton: UIButton!
    
    @IBOutlet var followingLabel: UILabel!
    @IBOutlet var postsLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    @IBOutlet weak var statsCollectionView: UICollectionView!
    @IBOutlet var avatarImage: UIImageView!
    
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    
    var profileData: ProfileData?
    var activeUsername: String?
    
    
    
    lazy var columnLayout = ColumnFlowLayout(
        cellsPerRow: 2,
        minimumInteritemSpacing: 17,
        minimumLineSpacing: 18,
        sectionInset: sectionInsets,
        autosetHeight: 101)
    
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statsCollectionView.register(UINib(nibName: "TopCell", bundle: nil), forCellWithReuseIdentifier: "TopCell")
        self.statsCollectionView.register(UINib(nibName: "SecondCell", bundle: nil), forCellWithReuseIdentifier: "SecondCell")
        statsCollectionView.collectionViewLayout = columnLayout
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width/2
        avatarImage.image = UIImage(named: "noAva")
        followersLabel.text = "Followers".localized()
        postsLabel.text = "Posts".localized()
        followingLabel.text = "Following".localized()
        
        self.edgesForExtendedLayout = [ UIRectEdge.bottom ]
        self.extendedLayoutIncludesOpaqueBars = true
        
#if DEBUG
        activeUsername = "test"
#endif
        
        updateData()
        setupData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - SetupData
    func setupData(){
#if DEBUG
        //ProfileDBService().createProfile(username: "test")
#endif
        
        guard let username = activeUsername else {return}
        print("username ", username)
        if let profile = ProfileDBService().getProfileData(username: username) {
            print("profile ", profile)
            
            self.profileData = profile
            followersCount.text = String(profile.followersCount)
            followingsCount.text = String(profile.followingsCount)
            postsCount.text = String(profile.postsCount)
            statsCollectionView.reloadData()
        }
        
        
    }
    
    func updateData(){
        guard let activeUsername = activeUsername else {
            return
        }
        
        let apiService = HomeStatsAPI()
        apiService.getHomeStats(username: activeUsername) { (result) -> () in
            
            do {
                try ProfileDBService().saveData(profileData: result.get(), username: activeUsername)
                self.setupData()
                
            } catch let error {
                print("getHomeStats error ", error)
                
                return
            }
        }
    }
    
    // MARK: - IBAction Button
    @IBAction func addAccount(_ sender: Any) {
        if let vc = UIStoryboard(name: "AddAccount", bundle: nil).instantiateViewController(withIdentifier: "AddAccount") as? AddAccountVC {
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }
    }
}


// MARK: - UICollectionViewDataSource
extension HomeStatsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if profileData != nil {
            return HomeStats.allCases.count + 2
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as! TopCell
            cell.topLabel.text = "🔥available now".localized()
            cell.mediumLabel.text = "Audience Insight".localized()
            cell.bottomLabel.text = "Followers statistical data".localized()
            cell.iconImage.image = UIImage(named: "topCell")
            cell.setBottomShadowCell()
            return cell
        }
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCell", for: indexPath) as! SecondCell
            cell.mediumLabel.text = "Who admires me".localized()
            cell.bottomLabel.text = "Based on your followers data".localized()
            return cell
        }
        else {
            let item = HomeStats.allCases[indexPath.item - 2]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeStatsCell", for: indexPath) as! HomeStatsCell
            cell.optionLabel.text = item.title
            cell.numberLabel.text = String(ProfileDBService().getValueForKey(profile: profileData!, key: item ))
            return cell
        }
    }
}


// MARK: - UICollectionViewDelegate
extension HomeStatsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item > 1 {
            let item = HomeStats.allCases[indexPath.item - 2]
            
            switch item.detailDataType.detailView {
            case .detailsMain:
                let vc = UIStoryboard(name: "DetailsMain", bundle: nil).instantiateViewController(withIdentifier: "DetailsMainVC") as! DetailsMainVC
                vc.title = item.detailDataType.title
                vc.dateType = item.detailDataType
                vc.username = self.activeUsername
                self.navigationController?.show(vc, sender: nil)
                self.tabBarController?.tabBar.isHidden = true
                
                break
                
            case .deletedLikesAndComments :
                let vc = UIStoryboard(name: "DeletedLikes", bundle: nil).instantiateViewController(withIdentifier: "DeletedLikes") as! DeletedLikes_CommentsVC
                vc.username = self.activeUsername
                self.navigationController?.show(vc, sender: nil)
                self.tabBarController?.tabBar.isHidden = true
                
                break
                
            case .topPosts, .topLikes:
                let vc = UIStoryboard(name: "TopPost", bundle: nil).instantiateViewController(withIdentifier: "TopPostVC") as! TopPostVC
                vc.title = item.detailDataType.title
                vc.dateType = item.detailDataType
                vc.username = self.activeUsername
                self.navigationController?.show(vc, sender: nil)
                self.tabBarController?.tabBar.isHidden = true
                
                break
                
            }
        }
    }
}

// MARK: - extension: UICollectionViewDelegateFlowLayout
extension HomeStatsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize: CGSize
        
        if indexPath.item < 2 {
            let itemWidth = collectionView.bounds.width - (sectionInsets.left + sectionInsets.right)
            itemSize = CGSize(width: itemWidth, height: 129)
        } else {
            let itemsPerRow: CGFloat = 2
            let paddingWidth = 20 * (itemsPerRow + 1)
            let availableWidth = collectionView.frame.width - paddingWidth
            let widthPerItem = availableWidth / itemsPerRow
            itemSize = CGSize(width: widthPerItem, height: widthPerItem * 0.75)
        }
        return itemSize
    }
}
