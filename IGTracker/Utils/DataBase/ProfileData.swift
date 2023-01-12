


import Foundation
import RealmSwift

class ProfileData: Object {
    @objc dynamic var key: String = NSUUID().uuidString

    @objc dynamic var username = ""
    @objc dynamic var createdTime = Date()
    @objc dynamic var followersCount: Int = 0
    @objc dynamic var followingsCount: Int = 0
    @objc dynamic var postsCount: Int = 0
    
    @objc dynamic var followersNew: Int = 0
    @objc dynamic var lostFollowers: Int = 0
    @objc dynamic var notFollowing: Int = 0
    @objc dynamic var dontFollowBack: Int = 0
    @objc dynamic var mutualFollowers: Int = 0
    @objc dynamic var whoUntaggedMe: Int = 0
    @objc dynamic var userBlockedMe: Int = 0
    @objc dynamic var storyViewersNew: Int = 0
    @objc dynamic var deletedLikesAndComments: Int = 0
    @objc dynamic var topCommentedPost : Int = 0
    @objc dynamic var topLikedPost : Int = 0

    
    
    override static func primaryKey() -> String? {
        return "key"
    }
    
}


class ProfileDBService {
    static let shared = RealmDB()
    let realmDB = try! Realm()
    
    func createProfile(username: String) -> ProfileData {
        let realm = try! Realm()

        let profileData = ProfileData()
        profileData.username = username
        try! realm.safeWrite {
            realm.add(profileData)
        }
        return profileData
    }
    
            
    
    func saveData(profileData: HomeStatsModel, username: String) {
        let realm = try! Realm()
        
        var profile: ProfileData!
        try! realm.safeWrite {

            profile = realmDB.objects(ProfileData.self).first(where: {$0.username == username}) ?? ProfileData()

            profile.username = username
            profile.dontFollowBack = profileData.dontFollowBack
            profile.followersNew = profileData.followersNew
            profile.lostFollowers = profileData.lostFollowers
            profile.mutualFollowers = profileData.mutualFollowers
            profile.notFollowing = profileData.notFollowing
            profile.dontFollowBack = profileData.dontFollowBack
            profile.storyViewersNew = profileData.storyViewersNew
            profile.topCommentedPost = profileData.topCommentedPost
            profile.topLikedPost = profileData.topLikedPost
            profile.deletedLikesAndComments = profileData.deletedLikesAndComments.amount

            realm.add(profile)
        }
    }
    
    func getProfileData(username: String) -> ProfileData? {
//        print("all objects ", realmDB.objects(ProfileData.self))
        return realmDB.objects(ProfileData.self).first(where: {$0.username == username})
    }
    
    func getValueForKey(profile: ProfileData, key: HomeStats) -> Int {
        return profile.value(forKey: key.rawValue) as! Int
    }
    
    
}

