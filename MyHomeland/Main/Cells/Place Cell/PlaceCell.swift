import UIKit
import Kingfisher

class PlaceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    
    @IBOutlet private weak var starsStackView: UIStackView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var favoritesButton: UIButton!
    
    var viewModel: PlaceCellViewModel? {
        didSet {
            self.setEmpty()
            if let model = self.viewModel {
                model.observe { (data) in
                    if let data = data {
                        self.set(imageWith: data.imageURL)
                        self.nameLabel.text = data.name
                        self.categoryLabel.text = data.category
                        self.set(stars: data.stars)
                        self.distanceLabel.text = data.distance
                    }
                }
            }
        }
    }
    
    func set(imageWith url: URL?) {
        self.backgroundImageView.kf.cancelDownloadTask()
        self.backgroundImageView.image = nil
        if let url = url {
            self.backgroundImageView.contentMode = .scaleAspectFill
            self.backgroundImageView.kf.setImage(with: url)
        }
        else {
            self.backgroundImageView.contentMode = .scaleAspectFit
            self.backgroundImageView.image = UIImage(named: "emptyPlacePhoto")
        }
    }
    
    func set(stars: Double) {
        var starsInt = Int(stars.rounded())
        for i in 0..<5 {
            (self.starsStackView.arrangedSubviews[i] as? UIImageView)?.image = UIImage(named: "cellStar\(starsInt <= 0 ? "Empty" : "Fill")")
            starsInt -= 1
        }
    }
    
    func setEmpty() {
        self.nameLabel.text = "---"
        self.set(imageWith: nil)
        self.categoryLabel.text = "---"
        self.set(stars: 0)
        self.distanceLabel.text = "? km"
    }
    
}
