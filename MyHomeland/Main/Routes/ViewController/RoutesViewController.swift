import UIKit

class RoutesViewController: UIViewController {

 
    @IBOutlet weak var addRoute: CustomButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension RoutesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RouteCell", for: indexPath)
        return cell
    }
    
    
}
