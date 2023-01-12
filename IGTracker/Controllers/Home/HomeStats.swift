import UIKit

enum HomeStats: String, CaseIterable {
    case followersNew
    case lostFollowers
    case notFollowing
    case dontFollowBack
    case mutualFollowers
//    case whoUntaggedMe
//    case userBlockedMe
    case storyViewersNew
    case deletedLikesAndComments
    case topCommentedPost
    case topLikedPost

    
    var title: String {
        switch self {
        case .followersNew:
            return "New followers".localized()
        case .lostFollowers:
            return "Lost followers".localized()
        case .notFollowing:
            return "Not following back".localized()
        case .dontFollowBack:
            return "I don't follow back".localized()
        case .mutualFollowers:
            return "Mutual followers".localized()
//        case .whoUntaggedMe:
//            return "Who untagged me".localized()
//        case .userBlockedMe:
//            return "User blocked me".localized()
        case .storyViewersNew:
            return "New story viewers".localized()
        case .deletedLikesAndComments:
            return "Deleted likes and comments".localized()
        case .topCommentedPost:
            return "Top commented post".localized()
        case .topLikedPost:
            return "Top liked post".localized()
        }
    }
    
    var detailDataType: DetailDataType {
        switch self {
        case .followersNew:
            return DetailDataType(title: "New followers".localized(), detailView: .detailsMain, url: "/new_followers/", tableViewCellType: .followersNew)
            
        case .lostFollowers:
            return DetailDataType(title: "Lost followers".localized(), detailView: .detailsMain, url: "/lost_followers/", tableViewCellType: .lostFollowers)
            
        case .notFollowing:
            return DetailDataType(title: "Not following back".localized(), detailView: .detailsMain, url: "/not_following_back/", tableViewCellType: .followersNew)
            
        case .dontFollowBack:
            return DetailDataType(title: "I don't follow back".localized(), detailView: .detailsMain, url: "/i_do_not_following_back/", tableViewCellType: .followersNew)
            
        case .mutualFollowers:
            return DetailDataType(title: "Mutual followers".localized(), detailView: .detailsMain, url: "/mutual_followers/", tableViewCellType: .followersNew)
            
        case .storyViewersNew:
            return DetailDataType(title: "New story viewers".localized(), detailView: .detailsMain, url: "/new_story_viewers/", tableViewCellType: .followersNew)
            
//        case .userBlockedMe:
//            return DetailDataType(title: "User blocked me".localized(), detailView: .detailsMain, url: "", tableViewCellType: .followersNew)
            
        case .deletedLikesAndComments:
            return DetailDataType(title: "Deleted likes and comments".localized(), detailView: .deletedLikesAndComments, url: "/deleted_likes_and_comments//", tableViewCellType: .followersNew)
        
        case .topCommentedPost:
            return DetailDataType(title: "Top commented post".localized(), detailView: .topPosts, url: "/top_commented_post/", tableViewCellType: .followersNew)
            
        case .topLikedPost:
            return DetailDataType(title: "Top liked posts".localized(), detailView: .topLikes, url: "/top_liked_post/", tableViewCellType: .followersNew)
            
//        case .whoUntaggedMe:
//            return DetailDataType(title: "Who untagged me".localized(), detailView: .topPosts, url: "", tableViewCellType: .followersNew)
        }
    }
    
}
