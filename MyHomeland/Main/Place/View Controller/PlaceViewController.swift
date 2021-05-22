import UIKit
import SVProgressHUD

class PlaceViewController: UIViewController {

    @IBOutlet private weak var segmentedControl: CustomSegmentedControl!
    
    @IBOutlet weak var containerView: UIView!
    
    var placeID: String?
    
    private var observerID: UInt?
    
    var infoVC: UIViewController!
    
    var previos: UIViewController?
    
    deinit {
        if let observerID = self.observerID, let placeID = self.placeID {
            AppDatabase.shared.removeObserver(forPlaceMainInfoWith: placeID, observerID: observerID)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infoVC = self.storyboard?.instantiateViewController(identifier: "placeInfo")
        ViewEmbedder.embed(parent: self, container: self.containerView, child: self.infoVC, previous: self.previos)
        self.previos = self.infoVC
        
        self.view.backgroundColor = ColorsCollection.defaultColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self,
                                                                 action: #selector(shareButtonTapped))

        self.segmentedControl.backgroundColor = ColorsCollection.defaultColor
        self.segmentedControl.setButtonTitles(buttonTitles: [ NSLocalizedString("Info", comment: "Info"), NSLocalizedString("Map", comment: "Map"),
                                                              NSLocalizedString("Photos", comment: "Photos"),
                                                              NSLocalizedString("Reviews", comment: "Reviews") ])
        self.segmentedControl.delegate = self
        
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        if let placeID = self.placeID {
            self.observerID = AppDatabase.shared.observe(placeMainInfoWith: placeID) {
                if let place = $0 {
                    self.navigationItem.title = place.name
                }
                SVProgressHUD.dismiss()
            }
        }
        else {
            SVProgressHUD.dismiss()
        }
    }
    
    @objc private func shareButtonTapped() {}

}

extension PlaceViewController: CustomSegmentedControlDelegate {
    
    func didSelect(index: Int) {
        if index == 0 {
            ViewEmbedder.embed(parent: self, container: self.containerView, child: self.infoVC, previous: self.previos)
            self.previos = self.infoVC
        }
        else {
            let vc = UIViewController()
            ViewEmbedder.embed(parent: self, container: self.containerView, child: vc, previous: self.previos)
            self.previos = vc
        }
    }
    
}
