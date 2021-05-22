//
//  CompilationViewController.swift
//  MyHomeland
//
//  Created by Александр Вторников on 06.11.2020.
//

import UIKit

class CompilationViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: CompilationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        viewModel = CompilationViewModel()
        viewModel?.getCompilation {
            self.collectionView.reloadData()
        }
    }
    
    private func UISetup() {
        self.view.backgroundColor = ColorsCollection.defaultColor
        self.collectionView.backgroundColor = ColorsCollection.defaultColor
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
        }
    }
}

extension CompilationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRow() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "compilationCell", for: indexPath) as? CompilationCollectionViewCell else { return UICollectionViewCell() }
        cell.configure()
        cell.viewModel = viewModel?.cellViewModel(forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(identifier: "CompilationDetailVC") as? CompilationDetailViewController else { return }
        detailVC.viewModel = viewModel?.viewModelForSelectedRow(atIndexPath: indexPath)
        detailVC.modalPresentationStyle = .pageSheet
        self.present(detailVC, animated: true, completion: nil)
    }
}

extension CompilationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.45)
    }
}


