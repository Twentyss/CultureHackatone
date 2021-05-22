//
//  EventDetailViewModel.swift
//  MyHomeland
//
//  Created by Александр Вторников on 17.11.2020.
//

import Foundation

class EventDetailViewModel {
    private var event: Event
    
    var name: String {
        return event.name
    }
    
    var region: String {
        return "\(event.region) район"
    }
    
    var imageURL: String {
        return event.image
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: event.date)
    }
    
    var description: String {
        return event.descrip ?? ""
    }
    
    init(event: Event) {
        self.event = event
    }
}
