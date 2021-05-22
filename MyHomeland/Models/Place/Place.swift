import CoreLocation
import SwiftyJSON


enum PlaceCategory: String {
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
    
}
