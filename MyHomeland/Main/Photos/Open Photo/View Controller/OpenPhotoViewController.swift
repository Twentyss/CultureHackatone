import UIKit

class OpenPhotoViewController: UIViewController {

    var image: UIImage?
    
    private var imageScrollView: ImageScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("Photo", comment: "Photo")
        self.view.backgroundColor = ColorsCollection.defaultColor
        self.imageScrollView = ImageScrollView(frame: self.view.bounds)
        if let image = self.image {
            self.view.addSubview(self.imageScrollView)
            self.setup(imageScrollView: self.imageScrollView, with: image)
        }
    }
    
    private func setup(imageScrollView: ImageScrollView, with image: UIImage) {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.topSpace + 10).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.bottomSpace - 10).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageScrollView.set(image: image)
    }

}
