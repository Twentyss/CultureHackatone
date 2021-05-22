import RxSwift
import CoreLocation

struct User {
    
    static let currentSubject = BehaviorSubject<User?>(value: nil)
    
    static let locationSubject = BehaviorSubject<CLLocationCoordinate2D?>(value: nil)
    
    let id: String
    
    var avatarURL: String
    
    var authInfo: AuthInfo
    
    var favorites: [String: String]
    
    var added: [String: String]
    
    var considered: [String: String]
    
    var rejected: [String: String]
    
    func toDictionary() -> [String: Any] {
        return [ "id": self.id, "avatarURL": self.avatarURL, "authInfo": self.authInfo.toDictionary(), "favorites": self.favorites,
                 "added": self.added, "consideration": self.considered, "rejected": self.rejected ]
    }
    
}
