import Foundation
import SwiftyJSON

extension AppDatabase {
    
    func observe(completion: @escaping ([CompilationItem]?) -> Void) {
        self.reference.child("compilation").observe(.value) { (snapshot) in
            guard let value = snapshot.value as? [String: AnyObject] else {
                completion(nil)
                return
            }
            let jsonValue = JSON(value)
            var compilationItems: [CompilationItem] = []
            for jsonItem in jsonValue {
                let item = CompilationItem(id: jsonItem.0, json: jsonItem.1)
                var placesId: [String] = []
                jsonItem.1["listPlace"].arrayValue.forEach { placesId.append($0.stringValue) }
                item.listPlace = placesId
                compilationItems.append(item)
            }
            completion(compilationItems)
        }
    }
    
    func observeRoutes(completion: @escaping ([Route]?) -> Void ) {
        self.reference.child("routes").observe(.value) { (snapshot) in
            guard let value = snapshot.value as? [String: AnyObject] else {
                
                completion(nil)
                return
            }
            
            let jsonValue = JSON(value)
            var routesItems: [Route] = []
            
            for jsonItem in jsonValue{
                var item = Route(with: jsonItem.0, and: jsonItem.1)
                var placesId: [String] = []
                jsonItem.1["listPlace"].array?.forEach { placesId.append($0.stringValue)}
                item.placesList = placesId
                routesItems.append(item)
            }
            
            
            completion(routesItems)
        }
    }
    
    func observeAllPlaces(completion: @escaping ([Place]?) -> ()) {
        self.reference.child("place").observe(.value) { (snapshot) in
            guard let value = snapshot.value as? [String: AnyObject] else {
                completion(nil)
                return
            }
            let jsonValue = JSON(value)
            var places: [Place] = []
            for jsonItem in jsonValue {
                let item = Place(id: jsonItem.0, json: jsonItem.1)
                places.append(item)
            }
            completion(places)
        }
    }
    
}
