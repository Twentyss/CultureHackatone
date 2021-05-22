import FirebaseStorage

struct AppStorage {
    
    static let shared = AppStorage()
    
    private init() {}
    
    func save(image: UIImage, completion: @escaping (URL?)->()) {
        let imageData = image.jpegData(compressionQuality: 0.5)!
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let reference = Storage.storage().reference()
            .child("images")
            .child(UUID().uuidString)
            reference.putData(imageData, metadata: metadata) { (metadata, error) in
                if metadata == nil {
                    completion(nil)
                    return
                }
                reference.downloadURL { (url, error) in
                    completion(url)
                }
        }
    }
    
    func download(imageBy url: URL, completion: @escaping (UIImage?)->()) {
        let reference = Storage.storage().reference(forURL: url.absoluteString)
        let maxSize: Int64 = 1024 * 1024 * 50
        reference.getData(maxSize: maxSize) { (data, error) in
            if data == nil {
                completion(nil)
                return
            }
            let image = UIImage(data: data!)
            completion(image)
        }
    }
    
    func remove(imageWith url: URL, completion: ((Error?)->())? = nil) {
        let reference = Storage.storage().reference(forURL: url.absoluteString)
        reference.delete { (error) in
            completion?(error)
        }
    }
    
}
