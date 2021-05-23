//
//  RoutePlacesViewController.swift
//  MyHomeland
//
//  Created by Илья Першин on 23.05.2021.
//

import UIKit

class RoutePlacesViewController: UIViewController, CustomSegmentedControlDelegate {
    func didSelect(index: Int) {
        print(index)
    }

    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var timeTextField: CustomTextField!
    
    
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var placesCollectionView: UICollectionView!
    
    var viewModel: RoutePlacesViewModel! {
        didSet {
            viewModel.fetchPlaces {
                self.placesCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func saveRoute(_ sender: Any) {
        
        let id = Int.random(in: 1...100)
        
        let route = Route(routeID: "place\(id)", routeName: nameTextField.text ?? "templateName", routeLenght: 50, placesList: viewModel.selectedPlacesID)
        
        AppDatabase.shared.addRoute(with: route)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RoutePlacesViewModel()
        
        segmentedControl.setButtonTitles(buttonTitles: ["Места", "Карта"])
        segmentedControl.delegate = self
    }
}


extension RoutePlacesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.placesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as! PlaceCollectionViewCell
        
        cell.viewModel = CellPlaceViewModel(with: viewModel.places[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PlaceCollectionViewCell
        viewModel.selectedPlacesID.append(cell.viewModel.place.id)
        cell.changeColor()
    }
}

extension RoutePlacesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width
        let height: CGFloat = width / 2
        return CGSize(width: width - 20, height: height)
    }
}
