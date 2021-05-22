//
//  Place.swift
//  MyHomeland
//
//  Created by Александр Вторников on 09.11.2020.
//

import Foundation
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

class Place {
    var category: PlaceCategory
    var countStars: Int
    var favorite: Bool
    var id: String
    var image: String
    var latitude: Double
    var location: String
    var longitude: Double
    var name: String

    init(category: PlaceCategory, countStars: Int, favorite: Bool, id: String, image: String, latitude: Double, location: String, longitude: Double, name: String) {
        self.category = category
        self.countStars = countStars
        self.favorite = favorite
        self.id = id
        self.image = image
        self.latitude = latitude
        self.location = location
        self.longitude = longitude
        self.name = name
    }
    
    init(json: JSON) {
        self.category = PlaceCategory.init(rawValue: json["category"].stringValue) ?? .other
        self.countStars = json["countStars"].intValue
        self.favorite = json["favorite"].boolValue
        self.id = json["id"].stringValue
        self.image = json["image"].stringValue
        self.latitude = json["latitude"].doubleValue
        self.location = json["location"].stringValue
        self.longitude = json["longitude"].doubleValue
        self.name = json["name"].stringValue
    }
    
    func toJSON() -> JSON {
        let json = JSON([
            "category": category.rawValue,
            "countStars": countStars,
            "favorite": favorite,
            "id": id,
            "image": image,
            "latitude": latitude,
            "location": location,
            "longitude": longitude,
            "name": name
        ])
        return json
    }
    
}
