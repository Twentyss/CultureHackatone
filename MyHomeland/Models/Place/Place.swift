import CoreLocation
import SwiftyJSON


enum PlaceCategory: String, CaseIterable {
    case culturalObjects = "Культурные объекты"
    case entertainmentFacilities = "Развлекательные объекты"
    case religiousSites = "Религиозные объекты"
    case historicalObjects = "Исторические объекты"
    case architecturalObjects = "Архитектурные объекты"
    case forTheFamily = "Для семьи"
    case waterBodies = "Водоёмы"
    case artisans = "Ремесленники"
    case romancePanoramas = "Панорамы\\Романтика"
    case serenityNature = "Безмятежность(природа)"
    case other
}

struct Place {
    
    let id: String
    
    var name: String
    
    var imageURL: String
    
    var category: PlaceCategory

    var stars: Double
    
    var location: CLLocationCoordinate2D
    
    var detail: DetailInfo?
    
    var region: String
    
    init(id: String, name: String, imageURL: String, category: PlaceCategory, stars: Double, location: CLLocationCoordinate2D, region: String,
         detail: DetailInfo? = nil) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.category = category
        self.stars = stars
        self.location = location
        self.detail = detail
        self.region = region
    }
    
    init(id: String, json: JSON) {
        self.id = id
        self.name = json["name"].stringValue
        self.region = json["location"].stringValue
        self.imageURL = json["image"].stringValue
        self.category = PlaceCategory.init(rawValue: json["category"].stringValue) ?? .other
        self.stars = json["countStars"].doubleValue
        let latitude = json["latitude"].doubleValue
        let longitude = json["longitude"].doubleValue
        self.location = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
    }
    
    func toDictionary() -> [String: Any] {
        var dicrionary = [ "name": self.name, "image": self.imageURL, "category": self.category.rawValue, "countStars": self.stars,
                           "latitude": self.location.latitude, "longitude": self.location.longitude, "region": self.region ] as [String : Any]
        if let detail = self.detail {
            dicrionary["descrip"] = detail.description
            dicrionary["countFavor"] = detail.favoritesCount
            dicrionary["countViews"] = detail.viewsCount
        }
        return dicrionary
    }
        
}



