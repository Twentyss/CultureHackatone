//
//  RoutePlacesViewModel.swift
//  MyHomeland
//
//  Created by Илья Першин on 23.05.2021.
//

import Foundation

class RoutePlacesViewModel {
    var places: [Place] = []
    var selectedPlacesID: [String] = []
    
    var placesCount: Int {
        places.count
    }
    
    func fetchPlaces(completion: @escaping () -> Void) {
        AppDatabase.shared.observeAllPlaces { places in
            guard let places = places else { return }
            
            self.places = places
            completion()
        }
    }
}
