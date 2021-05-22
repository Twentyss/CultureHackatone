import UIKit
import PhotosUI

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var imageRequestID: PHImageRequestID?
    
}
