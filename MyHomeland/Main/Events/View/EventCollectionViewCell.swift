//
//  EventCollectionViewCell.swift
//  MyHomeland
//
//  Created by Александр Вторников on 12.11.2020.
//

import UIKit
import Kingfisher

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var substrateView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    private let convexLayer = ConvexNeumorphismLayer(shadowType: .short)
    
    weak var viewModel: EventCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            dateLabel.text = viewModel.date
            regionLabel.text = viewModel.region
            nameLabel.text = viewModel.name
            imageView.kf.setImage(with: URL(string: viewModel.imageURL), placeholder: UIImage(named: "imagePlaceholder"))
        }
    }
    
    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        convexLayer.frame = substrateView.bounds
    }
    
    func configure() {
        UISetup()
    }
    
    private func UISetup() {
        self.backgroundColor = .clear
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        self.contentView.backgroundColor = .clear
        
        substrateView.backgroundColor = .clear
        substrateView.layer.insertSublayer(convexLayer, at: 0)
        substrateView.layer.cornerRadius = 10
        
        imageView.layer.cornerRadius = 10
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
        
        nameLabel.font = UIFont(name: "SFUIText-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = .white
        
        dateLabel.font = UIFont(name: "SFUIText-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .white
        
        regionLabel.font = UIFont(name: "SFUIText-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12)
        regionLabel.textColor = .white
        
    
        
    }
}

