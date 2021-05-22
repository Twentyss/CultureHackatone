import UIKit
import RxSwift
import PhotosUI
import CoreLocation
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var mainView: UIView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var segmentedControl: CustomSegmentedControl!
    
    @IBOutlet weak var emptyFavoritesLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var favoritesStackView: UIStackView!
    
    @IBOutlet weak var suggestionsStackView: UIStackView!
    
    @IBOutlet weak var suggestionsTableView: UITableView!
    
    let viewModel = ProfileViewModel()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.setButtonTitles(buttonTitles: [ NSLocalizedString("Favorites", comment: "Favorites"),
                                                         NSLocalizedString("My suggestions", comment: "My suggestions") ])
        segmentedControl.delegate = self
        
        self.view.backgroundColor = ColorsCollection.defaultColor
        self.mainView.backgroundColor = ColorsCollection.defaultColor
        
        self.nameLabel.font = UIFont(name: "SFUIText-Medium", size: 24) ?? UIFont.systemFont(ofSize: 24)
        self.nameLabel.textColor = ColorsCollection.tintColor
        
        self.tableView.backgroundColor = ColorsCollection.defaultColor
        self.suggestionsTableView.backgroundColor = ColorsCollection.defaultColor
        
        self.favoritesStackView.isHidden = !(self.segmentedControl.selectedIndex == 0)
        self.suggestionsStackView.isHidden = self.segmentedControl.selectedIndex == 0
        
        self.subscribe()
        
        self.checkLocationServices()
    }
    
    private func subscribe() {
        self.viewModel.subscribe { (avatarImage, name) in
            self.avatarImageView.image = avatarImage ?? UIImage(named: "avatar")
            self.nameLabel.text = name
            self.emptyFavoritesLabel.isHidden = self.viewModel.tableViewNumberOfRows != 0
            self.tableView.reloadData()
        }
        self.viewModel.subscribe {
            self.emptyFavoritesLabel.isHidden = self.viewModel.tableViewNumberOfRows != 0
            self.tableView.reloadData()
        }
    }
    
    @IBAction private func signOut() {
        let sheet = UIAlertController(title: nil,
                                      message: NSLocalizedString("Do you really want to sign out?", comment: "Do you really want to sign out?"),
                                      preferredStyle: .actionSheet)
        sheet.view.tintColor = ColorsCollection.tintColor
        sheet.addAction(UIAlertAction(title: NSLocalizedString("Sign out", comment: "Sign out"), style: .destructive, handler: { (_) in
            User.currentSubject.onNext(nil)
            SignIn.firebaseSignOut()
            if let rootVC = UIApplication.shared.windows.first?.rootViewController as? SignInViewController {
                rootVC.isInterfaceHidden = false
            }
            if let vc = self.tabBarController {
                vc.dismiss(animated: true, completion: nil)
            }
        }))
        sheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil))
        self.present(sheet, animated: true, completion: nil)
    }
    
    @IBAction private func avatarButtonTapped() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.view.tintColor = ColorsCollection.tintColor
        if !self.viewModel.isUserHasAvatar {
            self.addActions(forEmptyAvatarIn: sheet)
        }
        else {
            self.addActions(forAvatarIn: sheet)
        }
        sheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil))
        self.present(sheet, animated: true, completion: nil)
    }
    
    private func addActions(forEmptyAvatarIn alert: UIAlertController) {
        alert.addAction(UIAlertAction(title: NSLocalizedString("Add avatar", comment: "Add avatar"), style: .default, handler: { (_) in
            self.addAvatar()
        }))
    }
    
    private func addActions(forAvatarIn alert: UIAlertController) {
        alert.addAction(UIAlertAction(title: NSLocalizedString("Open avatar", comment: "Open avatar"), style: .default, handler: { (_) in
            let vc = OpenPhotoViewController()
            vc.image = self.avatarImageView.image
            self.show(vc, sender: self)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Change avatar", comment: "Change avatar"), style: .default, handler: { (_) in
            self.addAvatar()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Delete avatar", comment: "Delete avatar"), style: .destructive, handler: { (_) in
            self.deleteAvatar()
        }))
    }
    
    private func addAvatar() {
        let authStatus = PHPhotoLibrary.authorizationStatus()
        if #available(iOS 14.0, *), authStatus == .limited {
            PHPhotoLibrary.requestAuthorization { (_) in
                Photos.present(addPhotoControllerOn: self.tabBarController, delegate: self)
            }
        }
        else if authStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (result) in
                if #available(iOS 14.0, *), result == .limited {
                    Photos.present(addPhotoControllerOn: self.tabBarController, delegate: self)
                }
                else if result  == .authorized {
                    Photos.present(addPhotoControllerOn: self.tabBarController, delegate: self)
                }
            }
        }
        else if authStatus == .authorized {
            Photos.present(addPhotoControllerOn: self.tabBarController, delegate: self)
        }
        else {
            Photos.present(photosNoAccessAlertOn: self)
        }
    }
    
    private func deleteAvatar() {
        self.viewModel.deleteAvatar()
        self.avatarImageView.image = UIImage(named: "avatar")
    }
    
}

extension ProfileViewController: CLLocationManagerDelegate {
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.setLocation()
        }
        else {
            let alert = UIAlertController(title: NSLocalizedString("Location services disabled", comment: "Location services disabled"),
                                          message: NSLocalizedString("Enable location services in Settings.",
                                                                     comment: "Enable location services in Settings."),
                                          preferredStyle: .alert)
            alert.view.tintColor = ColorsCollection.tintColor
            alert.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Settings"), style: .default, handler: { (_) in
                if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setLocation() {
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        }
        else if status == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        else {
            let alert = UIAlertController(title: NSLocalizedString("Location using disabled", comment: "Location using disabled"),
                                          message: NSLocalizedString("Enable using location in Settings.", comment: "Enable using location in Settings."),
                                          preferredStyle: .alert)
            alert.view.tintColor = ColorsCollection.tintColor
            alert.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Settings"), style: .default, handler: { (_) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        User.locationSubject.onNext(locations.last?.coordinate)
    }
    
}

extension ProfileViewController: AddPhotoViewControllerDelegate {
    
    func addPhotoViewController(_ viewController: AddPhotoViewController, didFinishSelectingWith image: UIImage) {
        self.avatarImageView.image = image
        self.viewModel.removeAvatarFromStorage()
        AppStorage.shared.save(image: image) { (url) in
            if let avatarURL = url?.absoluteString, let id = Auth.auth().currentUser?.uid {
                AppDatabase.shared.save(avatarURL: avatarURL, for: id)
            }
        }
        viewController.dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView == self.tableView ? 1 : 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableView == self.tableView ? nil : self.viewModel.suggestionsTableViewSectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView, tableView == self.suggestionsTableView {
            if #available(iOS 14.0, *) {
                view.backgroundConfiguration?.backgroundColor = ColorsCollection.defaultColor
            }
            else {
                view.backgroundView?.backgroundColor = ColorsCollection.defaultColor
            }
            view.textLabel?.font = UIFont(name: "SFUIText-Semibold", size: 21)
            view.textLabel?.textColor = ColorsCollection.tintColor
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.tableView ? self.viewModel.tableViewNumberOfRows : self.viewModel.suggestionsTableView(numberOfRowsIn: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceCell
        if tableView == self.tableView {
            cell.viewModel = self.viewModel.placeCellViewModel(for: indexPath)
            cell.favoritesButton.isHidden = false
        }
        else {
            cell.viewModel = self.viewModel.suggestionsPlaceCellViewModel(for: indexPath)
            cell.favoritesButton.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            self.viewModel.favoritesTableView(didSelectRowAt: indexPath, presenter: self)
        }
    }
}

extension ProfileViewController: CustomSegmentedControlDelegate {
    
    func didSelect(index: Int) {
        let isFirstSegment = index == 0
        self.favoritesStackView.isHidden = !isFirstSegment
        self.suggestionsStackView.isHidden = isFirstSegment
    }
    
}
