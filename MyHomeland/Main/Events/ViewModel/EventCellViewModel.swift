import Foundation

class EventCellViewModel {
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
    
    init(event: Event) {
        self.event = event
    }
}