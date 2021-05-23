import FirebaseDatabase
import CoreLocation
import SwiftyJSON

extension AppDatabase {
    
    func observe(placeMainInfoWith id: String, completion: @escaping (Place?) -> Void) -> UInt {
        return self.reference.child("place").child(id).observe(.value) { (snapshot) in
            completion(self.get(placeFrom: snapshot, placeID: id))
        }
    }
    
    
    private func get(placeFrom snapshot: DataSnapshot, placeID id: String) -> Place? {
        if let value = snapshot.value as? [String: Any], let _ = value["name"] as? String {
            let jsonValue = JSON(value)
            return Place(id: value.keys.first!, json: jsonValue)
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
    
    func addRoute(with route: Route) {
        
        self.reference.child("routes").child(route.routeID).setValue(route.toDictionary())
    }
}
