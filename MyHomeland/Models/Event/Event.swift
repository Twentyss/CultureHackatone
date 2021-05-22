import Foundation
import SwiftyJSON

class Event {
    
    var id: String
    var date: Date
    var image: String
    var name: String
    var region: String
    
    // Event detail
    var descrip: String?
    var idPlace: String?

    init(date: Date, id: String, image: String, name: String, region: String) {
        self.date = date
        self.id = id
        self.image = image
        self.name = name
        self.region = region
    }
    
    init(id: String, json: JSON) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
        self.date = dateFormatter.date(from: "\(json["date"].stringValue) \(json["time"].stringValue)") ?? Date()
        self.id = json["id"].stringValue
        self.image = json["image"].stringValue
        self.name = json["name"].stringValue
        self.region = json["region"].stringValue
    }
    
    func addDetail(json: JSON) {
        self.descrip = json["descrip"].stringValue
        self.idPlace = json["idPlace"].stringValue
    }
    
    func toJSON() -> JSON {
        let calendar = Calendar.current
        let json = JSON([
            "id": id,
            "date": "\(calendar.component(.day, from: date)).\(calendar.component(.month, from: date)).\(calendar.component(.year, from: date))",
            "image": image,
            "name": name,
            "region": region,
            "time": "\(calendar.component(.hour, from: date)):\(calendar.component(.minute, from: date))"
        ])
        
        return json
    }
}
