import UIKit

class RoutesViewController: UIViewController {
    @IBOutlet weak var addRoute: CustomButton!
    @IBOutlet weak var routesCollectionView: UICollectionView!
    
    var viewModel: RoutesViewModel! {
        didSet {
            viewModel.fetchRoutes {
                self.routesCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RoutesViewModel()
    }
}

extension RoutesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let viewModel = viewModel else { return 0 }
        viewModel.numberOfRoutes()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RouteCell", for: indexPath) as! RouteCollectionViewCell
        
        cell.viewModel = CellViewModel(with: viewModel.routes[indexPath.item])
        
        return cell
    }    
}

extension RoutesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width
        let height: CGFloat = width / 2
        return CGSize(width: width - 20, height: height)
    }
}
