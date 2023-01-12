//
//  TopPostVC.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 15/09/22.
//

import UIKit


class TopPostVC: UIViewController {

    @IBOutlet var photosCollectionView: UICollectionView!
    

    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var days: UIButton!
    @IBOutlet var month: UIButton!
    @IBOutlet var year: UIButton!
    @IBOutlet var allTime: UIButton!
    
    var likePosts: [TopLikePosts] = []
    var commentPosts: [TopCommentPosts] = []
    var dateType: DetailDataType!
    var username: String!
    
    var selectedFilter: DurationFilter = .allTime

    override func viewDidLoad() {
        super.viewDidLoad()
        showFetch()
        allTime.titleLabel?.text = "All time".localized()
        month.titleLabel?.text = "30 days".localized()
        year.titleLabel?.text = "Year".localized()
        days.titleLabel?.text = "7 days".localized()
    }
    // MARK: - Buttons Actions
    
    @IBAction func filteredPosts(_ sender: UIButton) {
        buttons.forEach {
            $0.layer.backgroundColor = UIColor(named: "subbackground")?.cgColor
        }
        sender.layer.backgroundColor = UIColor(named: "pink")?.cgColor
    }
  
    @IBAction func filterDays(_ sender: Any) {
        if dateType.detailView == .topPosts {
            fetchComment()
        } else {
            fetchLike()
        }
    }
    
    @IBAction func filterMonth(_ sender: Any) {
    }
    
    @IBAction func filterYear(_ sender: Any) {
        selectedFilter = .year
        showFetch()
    }
    
    @IBAction func fiterAllTime(_ sender: Any) {
    }
    
    // MARK: - Fetch Methods
    private func showFetch() {
        if dateType.detailView == .topPosts {
            fetchComment()
        } else {
            fetchLike()
        }
    }
    
    private func fetchLike() {
        DetailsAPI.shared.getTopLikePost(durationFilter: selectedFilter) { result in
            switch result {
            case .success(let like):
                self.likePosts = like
                self.photosCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchComment() {
        DetailsAPI.shared.getTopCommentPost(durationFilter: selectedFilter) { result in
            switch result {
            case .success(let comment):
                self.commentPosts = comment
                self.photosCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension TopPostVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dateType.detailView == .topPosts {
            return commentPosts.count
        } else {
            return likePosts.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! TopPostCell
        
        if dateType.detailView == .topPosts {
            let like = commentPosts[indexPath.item]
            cell.commentsPost(num: like.commentCount)
            cell.photo.loadImageWithUrl(URL(string: like.image)!)
            
            return cell
        }
        else {
            let like = likePosts[indexPath.item]
            cell.likedPost(num: like.likeCount)
            cell.photo.loadImageWithUrl(URL(string: like.image)!)
            
            return cell
        }
    }
}


// MARK: - extension: UICollectionViewDelegateFlowLayout
extension TopPostVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    
}

// MARK: - extension: UICollectionViewDelegateFlowLayout
extension TopPostVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photosCollectionView.deselectItem(at: indexPath, animated: true)
    }
}


