import FirebaseDatabase
import CoreLocation

extension AppDatabase {
    
    func observe(placeMainInfoWith id: String, completion: @escaping (Place?) -> Void) -> UInt {
        return self.reference.child("place").child(id).observe(.value) { (snapshot) in
            completion(self.get(placeFrom: snapshot, placeID: id))
        }
    }
    
    private func get(placeFrom snapshot: DataSnapshot, placeID id: String) -> Place? {
        if let value = snapshot.value as? [String: Any], let name = value["name"] as? String {
            let imageURL = value["image"] as? String ?? ""
            let category = value["category"] as? String ?? ""
            let stars = value["countStars"] as? Double ?? 0
            let latitude = value["latitude"] as? Double ?? 0
            let longitude = value["longitude"] as? Double ?? 0
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            return Place(id: id, name: name, imageURL: imageURL, category: PlaceCategory.init(rawValue: category) ?? .other, stars: stars, location: location)
        }
        else {
            return nil
        }
    }
    
    func removeObserver(forPlaceMainInfoWith id: String, observerID: UInt) {
        self.reference.child("place").child(id).removeObserver(withHandle: observerID)
    }
    
    func observe(consideredPlaceWith id: String, completion: @escaping (Place?) -> Void) -> UInt {
        self.reference.child("placeConsidered").child(id).observe(.value) { (snapshot) in
            completion(self.get(placeFrom: snapshot, placeID: id))
        }
    }
    
    func removeObserver(forConsideredPlaceWith id: String, observerID: UInt) {
        self.reference.child("placeConsidered").child(id).removeObserver(withHandle: observerID)
    }
    
    func observe(rejectedPlaceWith id: String, completion: @escaping (Place?) -> Void) -> UInt {
        self.reference.child("placeRejected").child(id).observe(.value) {
            completion(self.get(placeFrom: $0, placeID: id))
        }
    }
    
    func removeObserver(forRejectedPlaceWith id: String, observerID: UInt) {
        self.reference.child("placeRejected").child(id).removeObserver(withHandle: observerID)
    }
    
}
