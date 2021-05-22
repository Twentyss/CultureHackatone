import UIKit

protocol AddPhotoViewControllerDelegate: class {
    
    func addPhotoViewController(_ viewController: AddPhotoViewController, didFinishSelectingWith image: UIImage)
    
}
