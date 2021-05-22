import FirebaseDatabase

extension AppDatabase {
    
    func save(authInfo: User.AuthInfo, for id: String) {
        self.reference.child("users").child(id).child("authInfo").setValue(authInfo.toDictionary())
    }
    
    func observe(userWith id: String, completion: @escaping (User?) -> Void) {
        self.reference.child("users").child(id).observe(.value) { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            guard let authInfoData = value["authInfo"] as? [String: String] else {
                completion(nil)
                return
            }
            let avatarURL = (value["avatarURL"] as? String) ?? ""
            let authInfo = User.AuthInfo(name: authInfoData["name"] ?? "", surname: authInfoData["surname"] ?? "", email: authInfoData["email"] ?? "")
            let favorites = value["favorites"] as? [String: String] ?? [:]
            let added = value["added"] as? [String: String] ?? [:]
            let considered = value["consideration"] as? [String: String] ?? [:]
            let rejected = value["rejected"] as? [String: String] ?? [:]
            completion(User(id: id, avatarURL: avatarURL, authInfo: authInfo, favorites: favorites, added: added, considered: considered, rejected: rejected))
        }
    }
    
    func save(avatarURL: String, for id: String) {
        self.reference.child("users").child(id).child("avatarURL").setValue(avatarURL)
    }
    
    func remove(avatarURLFor id: String) {
        self.reference.child("users").child(id).child("avatarURL").removeValue()
    }
    
}
