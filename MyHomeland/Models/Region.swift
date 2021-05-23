//
//  Region.swift
//  MyHomeland
//
//  Created by Александр Вторников on 24.11.2020.
//

import Foundation
import SwiftyJSON
import RxSwift

class Region {
    
    static let allSubject = BehaviorSubject<[Region]>(value: [])
    
    var id: String
    var count: Int
    var image: String
    var region: String
    
    init(id: String, count: Int, image: String, region: String) {
        self.id = id
        self.count = count
        self.image = image
        self.region = region
    }
    
    init(id: String, json: JSON) {
        self.id = id
        self.count = json["count"].intValue
        self.image = json["image"].stringValue
        self.region = json["region"].stringValue
    }
    
    func toJSON() -> JSON {
        return JSON([
            "id": id,
            "count": count,
            "image": image,
            "region": region
        ])
    }
}
