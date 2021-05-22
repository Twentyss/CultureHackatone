import Foundation
import SwiftyJSON

extension AppDatabase {
    
    func observeEvents(completion: @escaping ([Event]?) -> Void) {
        self.reference.child("events").observe(.value) { (snapshot) in
            guard let value = snapshot.value as? [String: AnyObject] else {
                completion(nil)
                return
            }
            let jsonValue = JSON(value)
            var events: [Event] = []
            for jsonItem in jsonValue {
                events.append(Event(id: jsonItem.0, json: jsonItem.1))
            }
            completion(events)
        }
    }
    
    func getEventDetail(event: Event, completion: @escaping () -> Void) {
        self.reference.child("eventsDescrip").child(event.id).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value as? [String: AnyObject] else {
                completion()
                return
            }
            let jsonValue = JSON(value)
            event.addDetail(json: jsonValue)
            completion()
        })
    }
    
}
