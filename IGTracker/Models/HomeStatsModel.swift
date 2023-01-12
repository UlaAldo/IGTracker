



struct HomeStatsModel: Decodable {
    let followersNew: Int
    let lostFollowers: Int
    let notFollowing: Int
    let dontFollowBack: Int
    let mutualFollowers: Int
    let storyViewersNew: Int
    var deletedLikesAndComments: ForDelete
    let topCommentedPost: Int
    let topLikedPost: Int

    enum CodingKeys: String, CodingKey {
        case followersNew = "count_new_followers"
        case lostFollowers = "count_lost_followers"
        case notFollowing = "not_following_back"
        case dontFollowBack = "i_do_not_following_back"
        case mutualFollowers = "mutual_followers"
        case storyViewersNew = "new_story_viewers"
        case deletedLikesAndComments = "deleted_likes_and_comments"
        case topCommentedPost = "top_commented_post"
        case topLikedPost = "top_liked_post"

    }
}

enum DeletedType: Int, Decodable {
    case deletedComments
    case deletedLikes
    
    enum CodingKeys: String, CodingKey {
        case deletedComments = "deleted_comments_count"
        case deletedLikes = "deleted_likes_count"
    }
}

struct ForDelete: Decodable {
    var amount: Int {
        DeletedType.deletedLikes.rawValue + DeletedType.deletedLikes.rawValue
    }
}
