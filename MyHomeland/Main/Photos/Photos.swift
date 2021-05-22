import UIKit

struct Photos {
    
    static func present(addPhotoControllerOn presenter: UIViewController?, delegate: AddPhotoViewControllerDelegate?) {
        let storyboard = UIStoryboard(name: "Photos", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "addPhotoVC") as? UINavigationController,
           let rootVC = vc.viewControllers.first as? AddPhotoViewController  {
            rootVC.delegate = delegate
            presenter?.present(vc, animated: true, completion: nil)
        }
    }
    
    static func present(photosNoAccessAlertOn presenter: UIViewController) {
        let alert = UIAlertController(title: NSLocalizedString("No access to Photos", comment: "No access to Photos"),
                                      message: NSLocalizedString("Allow access to yor photos in Settings.",
                                                                 comment: "Allow access to yor photos in Settings."),
                                      preferredStyle: .alert)
        alert.view.tintColor = ColorsCollection.tintColor
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
    
    private init() {}
    
}
