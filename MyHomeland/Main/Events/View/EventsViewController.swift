import UIKit

class EventsViewController: UIViewController {
    
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    
    var viewModel: EventsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        
        viewModel = EventsViewModel()
        viewModel?.getEvents {
            self.eventsCollectionView.reloadData()
        }

        UISetup()

    }
    
    private func UISetup() {
        self.view.backgroundColor = ColorsCollection.defaultColor
        self.eventsCollectionView.backgroundColor = ColorsCollection.defaultColor
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
        }
    }

}

extension EventsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRow() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventCollectionViewCell else { return UICollectionViewCell() }
        cell.configure()
        cell.viewModel = viewModel?.cellViewModel(forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(identifier: "EventDetailVC") as? EventDetailViewController else { return }
        detailVC.modalPresentationStyle = .pageSheet
        viewModel?.viewModelForSelectedRow(atIndexPath: indexPath) { eventDetailViewModel in
            detailVC.viewModel = eventDetailViewModel
            self.present(detailVC, animated: true, completion: nil)
        }
    }
}

extension EventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
}
