


// MARK: - Followers
struct Followers: Decodable {
    let fullName: String
    let userName: String
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case userName = "username"
        case avatar = "avatar"
    }
}


// MARK: - DeletedPost
struct DeletedPost: Decodable {
    let deletedComments: [Comments]
    let deletedLikes: [Likes]
    
    enum CodingKeys: String, CodingKey {
        case deletedComments = "deleted_comments"
        case deletedLikes = "deleted_likes"
    }
}

struct Comments: Decodable {
    let user: UserComment
    let post: PostComment
    let dateDeleted: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
        case post = "post"
        case dateDeleted = "date_deleted"
        case text = "text"
    }
}

struct UserComment: Decodable {
    let fullName: String
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case avatar = "avatar"
    }
}

struct PostComment: Decodable {
    let image: String
}

struct Likes: Decodable {
    let user: UserLikes
    let post: PostLikes
    let dateDeleted: String
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
        case post = "post"
        case dateDeleted = "date_deleted"
    }
}

struct UserLikes: Decodable {
    let fullName: String
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case avatar = "avatar"
    }
}

struct PostLikes: Decodable {
    let image: String
}

// MARK: - TopPosts

struct TopLikePosts: Decodable {
    let image: String
    let likeCount: Int
    
    enum CodingKeys: String, CodingKey {
        case image = "image"
        case likeCount = "like_count"
    }
}

struct TopCommentPosts: Decodable {
    let image: String
    let commentCount: Int
    
    enum CodingKeys: String, CodingKey {
        case image = "image"
        case commentCount = "comment_count"
    }
}


enum DurationFilter: String {
    case allTime
    case year
    case month
    case week
}

// MARK: - DetailDataType

struct DetailDataType {
    let title: String
    let detailView: DataDetailClassName
    let url: String
    let tableViewCellType: DetailsCellType
}

enum DetailsCellType {
    case followersNew
    case lostFollowers
    case notFollowing
    case dontFollowBack
    case mutualFollowers
    case storyViewersNew
    case userBlockedMe
    case topCommentPosts
    case topLikedPosts
    case deletedLikesAndComments
    case whoUntaggedMe
  
}

enum DataDetailClassName {
    case detailsMain
    case deletedLikesAndComments
    case topLikes
    case topPosts
}

