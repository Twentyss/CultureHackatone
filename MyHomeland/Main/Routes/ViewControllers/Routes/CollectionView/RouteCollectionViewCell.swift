import UIKit

class RouteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var routeLenght: UILabel!
    
    @IBOutlet weak var routeImage: UIImageView!
    
    @IBOutlet weak var blurView: UIView!
    
    
    var viewModel: CellViewModel! {
        didSet {
            setupUI()
            setupImage()
        }
    }
    
    private func setupUI() {
        routeName.text = viewModel.route.routeName
        routeLenght.text = "\(viewModel.route.routeLenght)" + " km"
        
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 25
        
        blurView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    }
    
    private func setupImage() {
        let placeId = viewModel.route.placesList.first
        
        AppDatabase.shared.observeAllPlaces { places in
            
            guard let places = places else {
                return
            }
            
            var urlString = ""
            
            for place in places {
                if place.id == placeId {
                    urlString = place.imageURL
                }
            }
        
            guard let imageURL = URL(string: urlString) else { return }
            
            self.routeImage.kf.setImage(with: imageURL, placeholder: UIImage(named: "imagePlaceholder"))
        }
    }
}
