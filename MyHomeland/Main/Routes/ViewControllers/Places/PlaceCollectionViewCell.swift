//
//  PlaceCollectionViewCell.swift
//  MyHomeland
//
//  Created by Илья Першин on 23.05.2021.
//

import UIKit

class CellPlaceViewModel {
    let place: Place
    
    
    
    init(with place: Place) {
        self.place = place
    }
}

class PlaceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    
    @IBOutlet weak var groupImage: UIImageView!
    
    var viewModel: CellPlaceViewModel! {
        didSet {
            setupUI()
        }
    }
    
    override func prepareForReuse() {
        placeImage.kf.cancelDownloadTask()
        placeImage.image = nil
    }
    
    func setupUI() {
        placeName.text = viewModel.place.name
        
        guard let imageURL = URL(string: viewModel.place.imageURL) else {
            return
        }
        
        placeImage.kf.setImage(with: imageURL, placeholder: UIImage(named: "imagePlaceholder"))
        
        blurView.backgroundColor = .clear
        
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 25
    }
    

    
    func changeColor() {
        if blurView.backgroundColor == UIColor(red: 0, green: 0, blue: 0, alpha: 0.4) {
            blurView.backgroundColor = .clear
            groupImage.isHidden = true
        } else {
            blurView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            groupImage.isHidden = false
        }
    }
}


