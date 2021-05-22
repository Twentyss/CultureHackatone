//
//  EventsViewModel.swift
//  MyHomeland
//
//  Created by Александр Вторников on 12.11.2020.
//

import Foundation

class EventsViewModel {
    private var selectedIndexPath: IndexPath?
    
    var events: [Event] = []
    
    func getEvents(completion: @escaping ()->()) {
        AppDatabase.shared.observeEvents{ (events) in
            if let events = events {
                self.events = events.sorted { $0.date < $1.date }
                completion()
            }
        }
    }
    
    func numberOfRow() -> Int {
        return events.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> EventCellViewModel? {
        let event = events[indexPath.row]
        return EventCellViewModel(event: event)
    }

    func viewModelForSelectedRow(atIndexPath indexPath: IndexPath, with completion: @escaping (EventDetailViewModel?) -> ()) {
        AppDatabase.shared.getEventDetail(event: events[indexPath.row]) {
            completion(EventDetailViewModel(event: self.events[indexPath.row]))
        }
    }
}
