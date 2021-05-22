extension User {
    
    struct AuthInfo {
        
        var name: String
        
        var surname: String
        
        var email: String
        
        var isEmpty: Bool {
            return self.name.isEmpty && self.surname.isEmpty && self.email.isEmpty
        }
        
        func toDictionary() -> [String: String] {
            return [ "name": self.name, "surname": self.surname, "email": self.email ]
        }
        
    }
    
}
