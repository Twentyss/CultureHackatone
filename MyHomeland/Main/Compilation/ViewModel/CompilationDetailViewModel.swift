import Foundation
import RxSwift
import FirebaseAuth
import CoreLocation

class CompilationDetailViewModel {
    
    private var compilationItem: CompilationItem
    private var selectedIndexPath: IndexPath?
    private var locationSubscription: Disposable?
    private var location: CLLocation?

    private let bag = DisposeBag()
    
    func subscribe(locationOnNext: @escaping () -> Void) {
        self.locationSubscription = User.locationSubject.subscribe(onNext: {
            if let old = self.location?.coordinate,
               let current = $0, abs(old.latitude - current.latitude) > 0.0002, abs(old.longitude - current.longitude) > 0.0002 {
                self.location = CLLocation(latitude: current.latitude, longitude: current.longitude)
                locationOnNext()
            }
            else if self.location == nil && $0 != nil {
                self.location = CLLocation(latitude: $0!.latitude, longitude: $0!.longitude)
                locationOnNext()
            }
        })
        self.locationSubscription?.disposed(by: self.bag)
    }
    
    var name: String {
        return compilationItem.name
    }
    
    var description: String {
        return compilationItem.descrip
    }
    
    var imageURL: String {
        return compilationItem.image
    }
    
    var detailDescription: String {
        return compilationItem.content
    }
    
    init(compilationItem: CompilationItem) {
        self.compilationItem = compilationItem
    }
    
    func numberOfRowOfPlaces() -> Int {
        return compilationItem.listPlace.count
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func placeCellViewModel(for indexPath: IndexPath) -> PlaceCellViewModel {
        let placeID = self.compilationItem.listPlace[indexPath.row]
        return PlaceCellViewModel(placeID: placeID, userLocation: self.location)
    }
    
}
