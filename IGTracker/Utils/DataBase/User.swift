


import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var isSubscribed = false
    @objc dynamic var isOnboardingShowed = false
    @objc dynamic var isReviewShowed = false
    @objc dynamic var userInterfaceStyle = 1

}


class RealmDB {
    
    static let shared = RealmDB()
    fileprivate let realm = try! Realm()
    
    
    func deleteUser() {
        try! realm.safeWrite {
            realm.delete(User())
        }
    }
    
    func createUser() {
        try! realm.safeWrite {
            realm.add(User())
        }
    }
    
    func getUser() -> User {
        guard let user = realm.objects(User.self).first else {
            createUser()
            return getUser()
        }
        return user
    }

    func setOnboardingShowed() {
        try! realm.safeWrite {
            self.getUser().isOnboardingShowed = true
        }
    }
    
    func setReviewShowed() {
        try! realm.safeWrite {
            self.getUser().isReviewShowed = true
        }
    }
    
    func setIsSubscribed(_ isSubscribed: Bool) {
        try! realm.safeWrite {
            self.getUser().isSubscribed = isSubscribed
        }
    }
    
    func setUserInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle) {
        try! realm.safeWrite {
            self.getUser().userInterfaceStyle = userInterfaceStyle.rawValue
        }
    }
}

extension Realm {
    
    func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}



