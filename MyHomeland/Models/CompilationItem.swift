import Foundation
import SwiftyJSON

class CompilationItem {
    
    var id: String
    var content, descrip: String
    var image: String
    var listPlace: [String]
    var name: String
    
    init(id: String, content: String, descrip: String, image: String, listPlace: [String], name: String) {
        self.id = id
        self.content = content
        self.descrip = descrip
        self.image = image
        self.listPlace = listPlace
        self.name = name
    }
    
    init(id: String, json: JSON) {
        self.id = id
        self.content = json["content"].stringValue
        self.descrip = json["descrip"].stringValue
        self.image = json["image"].stringValue
        self.listPlace = []
        self.name = json["name"].stringValue
    }
    
    func toJSON() -> JSON {        
        let json = JSON([
            "content": content,
            "descrip": descrip,
            "id": id,
            "image": image,
            "listPlace": listPlace,
        ])
        return json
    }
}
