import RxSwift
import FirebaseAuth
import CoreLocation

class ProfileViewModel {
    
    private var userSubscription: Disposable!
    
    private var locationSubscription: Disposable!
    
    private let bag = DisposeBag()
    
    private var avatarURL = ""
    
    private var favorites: [String] = []
    
    private var added: [String] = []
    
    private var considered: [String] = []
    
    private var rejected: [String] = []
    
    private var location: CLLocation?
    
    var isUserHasAvatar: Bool { !avatarURL.isEmpty }
    
    var tableViewNumberOfRows: Int { self.favorites.count }
    
    private let suggestionsTableViewTitles = [ NSLocalizedString("Added", comment: "Added"), NSLocalizedString("On review", comment: "On review"),
                                       NSLocalizedString("Rejected", comment: "Rejected") ]
    
    func subscribe(userOnNext: @escaping (UIImage?, String) -> Void) {
        self.userSubscription = User.currentSubject.subscribe(onNext: {
            if let user = $0 {
                self.avatarURL = user.avatarURL
                self.favorites = user.favorites.values.sorted()
                self.added = user.added.values.sorted()
                self.considered = user.considered.values.sorted()
                self.rejected = user.rejected.values.sorted()
                if let url = URL(string: self.avatarURL) {
                    AppStorage.shared.download(imageBy: url) { (image) in
                        userOnNext(image, user.authInfo.name + " " + user.authInfo.surname)
                    }
                }
                else {
                    userOnNext(nil, user.authInfo.name + " " + user.authInfo.surname)
                }
            }
        })
        self.userSubscription.disposed(by: self.bag)
    }
    
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
        self.locationSubscription.disposed(by: self.bag)
    }
    
    func deleteAvatar() {
        let oldAvatarURLString = self.avatarURL
        self.avatarURL = ""
        if let oldAvatarURL = URL(string: oldAvatarURLString) {
            AppStorage.shared.remove(imageWith: oldAvatarURL)
        }
        if let id = Auth.auth().currentUser?.uid {
            AppDatabase.shared.remove(avatarURLFor: id)
        }
    }
    
    func removeAvatarFromStorage() {
        if let url = URL(string: self.avatarURL) {
            AppStorage.shared.remove(imageWith: url)
        }
    }
    
    func placeCellViewModel(for indexPath: IndexPath) -> PlaceCellViewModel {
        let placeID = self.favorites[indexPath.row]
        return PlaceCellViewModel(placeID: placeID, userLocation: self.location)
    }
    
    func suggestionsPlaceCellViewModel(for indexPath: IndexPath) -> PlaceCellViewModel {
        if indexPath.section == 0 {
            let placeID = self.added[indexPath.row]
            return PlaceCellViewModel(placeID: placeID, userLocation: self.location)
        }
        else if indexPath.section == 1 {
            let placeID = self.considered[indexPath.row]
            return ConsideredPlaceCellViewModel(placeID: placeID, userLocation: self.location)
        }
        else {
            let placeID = self.rejected[indexPath.row]
            return RejectedPlaceCellViewModel(placeID: placeID, userLocation: self.location)
        }
    }
    
    func suggestionsTableView(numberOfRowsIn section: Int) -> Int {
        if section == 0 { return self.added.count }
        else if section == 1 { return self.considered.count }
        else { return self.rejected.count }
    }
    
    func suggestionsTableViewSectionTitle(for section: Int) -> String {
        return self.suggestionsTableViewTitles[section]
    }
    
    func favoritesTableView(didSelectRowAt indexPath: IndexPath, presenter: UIViewController) {
        if let vc = UIStoryboard(name: "Place", bundle: nil).instantiateInitialViewController() as? PlaceViewController {
            vc.placeID = self.favorites[indexPath.row]
            presenter.show(vc, sender: presenter)
        }
    }
    
}
