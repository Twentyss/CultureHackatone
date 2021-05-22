import FirebaseDatabase

struct AppDatabase {
    
    static let shared = AppDatabase()
    
    let reference = Database.database().reference()
    
}
