import UIKit
import PhotosUI

class AddPhotoViewController: UICollectionViewController {

    var assets = PHFetchResult<PHAsset>()
    
    weak var delegate: AddPhotoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = ColorsCollection.defaultColor
        PHPhotoLibrary.shared().register(self)
        let options = PHFetchOptions()
        options.sortDescriptors = [ NSSortDescriptor(key: "creationDate", ascending: false) ]
        self.assets = PHAsset.fetchAssets(with: .image, options: options)
        self.collectionView.reloadData()
    }
    
    @IBAction private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        if let oldID = cell.imageRequestID {
            PHImageManager.default().cancelImageRequest(oldID)
        }
        if indexPath.item == 0 {
            cell.photoImageView.image = UIImage(named: "makePhotoCell")
        }
        else {
            let asset = self.assets[indexPath.item - 1]
            let targetSize = CGSize(width: 200, height: 200)
            cell.imageRequestID = PHImageManager.default()
                .requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil, resultHandler: { (image, _) in
                    cell.photoImageView.image = image
                })
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
        else {
            let asset = self.assets[indexPath.item - 1]
            
            let options = PHImageRequestOptions()
            options.resizeMode = .none
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize.zero, contentMode: .default, options: options) { (image, _) in
                if let image = image {
                    self.delegate?.addPhotoViewController(self, didFinishSelectingWith: image)
                }
            }
        }
    }
    
}

extension AddPhotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = self.collectionView.frame.width / 3 - 1
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

extension AddPhotoViewController: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        let options = PHFetchOptions()
        options.sortDescriptors = [ NSSortDescriptor(key: "creationDate", ascending: false) ]
        self.assets = PHAsset.fetchAssets(with: .image, options: options)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.delegate?.addPhotoViewController(self, didFinishSelectingWith: image)
        }
    }
    
}
