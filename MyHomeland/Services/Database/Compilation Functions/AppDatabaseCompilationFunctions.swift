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
    
}
