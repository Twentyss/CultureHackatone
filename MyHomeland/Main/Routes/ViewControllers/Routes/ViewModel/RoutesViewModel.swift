import Foundation
import SwiftyJSON

struct Route {
    let routeID: String
    let routeName: String
    let routeLenght: Double
    let starsCount: Int
    let time: String
    var placesList: [String]
    
    func toDictionary() -> [String: Any] {
            ["routeName": self.routeName, "routeLenght": self.routeLenght,
             "starsCount": self.starsCount, "startDate": self.time,
             "listPlace": self.placesList]
        }
    
    init(with id: String, and json: JSON) {
        self.routeID = json["routeID"].stringValue
        self.routeName = json["routeName"].stringValue
        self.routeLenght = json["routeLenght"].doubleValue
        self.starsCount = json["starsCount"].intValue
        self.time = json["time"].stringValue
        self.placesList = []
    }
    
    init(routeID: String, routeName: String, routeLenght: Double, starsCount: Int = 5, time: String = "", placesList: [String]) {
        self.routeID = routeID
        self.routeName = routeName
        self.routeLenght = routeLenght
        self.starsCount = starsCount
        self.time = time
        self.placesList = placesList
    }
}


class RoutesViewModel {
    var routes: [Route] = []
    
    func fetchRoutes(completion: @escaping () -> Void) {
        AppDatabase.shared.observeRoutes { (routes) in
            guard let routes = routes else { return }
            self.routes = routes
            completion()
        }
    }
    
    func numberOfRoutes() -> Int {
        routes.count
    }
}

class CellViewModel {
    var route: Route
    
    init(with route: Route) {
        self.route = route
    }
}
