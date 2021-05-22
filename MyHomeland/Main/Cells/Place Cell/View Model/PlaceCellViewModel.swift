import CoreLocation

class PlaceCellViewModel {
    
    struct Data {
        
        let imageURL: URL?
        
        let name: String
        
        let category: String
        
        let stars: Double
        
        let distance: String
        
    }
    
    let placeID: String
    
    let userLocation: CLLocation?
    
    var observerID: UInt?
    
    init(placeID: String, userLocation: CLLocation? = nil) {
        self.placeID = placeID
        self.userLocation = userLocation
    }
    
    deinit {
        self.removeObserver()
    }
    
    func removeObserver() {
        if let observerID = self.observerID {
            AppDatabase.shared.removeObserver(forPlaceMainInfoWith: self.placeID, observerID: observerID)
        }
    }
    
    func observe(completion: @escaping (PlaceCellViewModel.Data?) -> Void) {
        self.observerID = AppDatabase.shared.observe(placeMainInfoWith: self.placeID) {
            completion(self.get(placeDataFor: $0))
        }
    }
    
    func get(placeDataFor place: Place?) -> PlaceCellViewModel.Data? {
        if let place = place {
            let distanceString: String
            if let location = self.userLocation {
                let placeLocation = CLLocation(latitude: place.location.latitude, longitude: place.location.longitude)
                let distance = location.distance(from: placeLocation) / 1000
                distanceString = "\(Int(distance.rounded())) km"
            }
            else {
                distanceString = "? km"
            }
            return PlaceCellViewModel.Data(imageURL: URL(string: place.imageURL),
                                      name: place.name, category: place.category.rawValue, stars: place.stars, distance: distanceString)
        }
        else { return nil }
    }
    
}

class ConsideredPlaceCellViewModel: PlaceCellViewModel {
    
    override func observe(completion: @escaping (PlaceCellViewModel.Data?) -> Void) {
        self.observerID = AppDatabase.shared.observe(consideredPlaceWith: self.placeID) {
            completion(self.get(placeDataFor: $0))
        }
    }
    
    override func removeObserver() {
        if let observerID = self.observerID {
            AppDatabase.shared.removeObserver(forConsideredPlaceWith: self.placeID, observerID: observerID)
        }
    }
    
}

class RejectedPlaceCellViewModel: PlaceCellViewModel {
    
    override func observe(completion: @escaping (PlaceCellViewModel.Data?) -> Void) {
        self.observerID = AppDatabase.shared.observe(rejectedPlaceWith: self.placeID) {
            completion(self.get(placeDataFor: $0))
        }
    }
    
    override func removeObserver() {
        if let observerID = self.observerID {
            AppDatabase.shared.removeObserver(forRejectedPlaceWith: self.placeID, observerID: observerID)
        }
    }
    
}
