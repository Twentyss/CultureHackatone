//
//  CompilationCollectionViewCell.swift
//  MyHomeland
//
//  Created by Александр Вторников on 06.11.2020.
//

import UIKit
import Kingfisher

class CompilationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var substrateView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let convexLayer = ConvexNeumorphismLayer(shadowType: .short)
    
    weak var viewModel: CompilationCollectionViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            nameLabel.text = viewModel.name
            descriptionLabel.text = viewModel.description
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
        self.substrateView.backgroundColor = .clear
        substrateView.layer.insertSublayer(convexLayer, at: 0)
        substrateView.layer.cornerRadius = 10
        imageView.layer.cornerRadius = 10
        
        nameLabel.font = UIFont(name: "SFUIText-Medium", size: 12) ?? UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = ColorsCollection.textGray
        
        descriptionLabel.font = UIFont(name: "SFUIText-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)
        descriptionLabel.textColor = ColorsCollection.textDarkGray
        
    }
}
