//
//  EventDetailViewController.swift
//  MyHomeland
//
//  Created by Александр Вторников on 17.11.2020.
//

import UIKit
import Kingfisher

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var placeButton: UIButton!
    @IBOutlet weak var substrateView: UIView!

    
    var viewModel: EventDetailViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        guard let viewModel = viewModel else  { return }
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
        regionLabel.text = viewModel.region
        imageView.kf.setImage(with: URL(string: viewModel.imageURL), placeholder: UIImage(named: "imagePlaceholder"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UISetup()
    }
    
    private func UISetup() {
        
        self.view.backgroundColor = ColorsCollection.defaultColor
        substrateView.backgroundColor = ColorsCollection.defaultColor
        
        nameLabel.font = UIFont(name: "SFUIText-Medium", size: 24) ?? UIFont.systemFont(ofSize: 24)
        nameLabel.textColor = ColorsCollection.textDarkGray
        
        dateLabel.font = UIFont(name: "SFUIText-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = ColorsCollection.textDarkGray
        
        regionLabel.font = UIFont(name: "SFUIText-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12)
        regionLabel.textColor = ColorsCollection.textDarkGray
        
        descriptionLabel.font = UIFont(name: "SFUIText-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)
        descriptionLabel.textColor = ColorsCollection.textDarkGray
        
        placeButton.titleLabel?.font = UIFont(name: "SFUIText-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
        placeButton.titleLabel?.textColor = ColorsCollection.tintColor
        placeButton.setTitle("Место проведения события", for: .normal)
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
