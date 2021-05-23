import UIKit

class RouteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var routeLenght: UILabel!
    
    
    var viewModel: CellViewModel! {
        didSet {
            setupUI()
        }
    }
    
    private func setupUI() {
        routeName.text = viewModel.route.routeName
        routeLenght.text = "\(viewModel.route.routeLenght)"
        
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 25
    }
}
