import UIKit

class CompilationDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var placesTableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navView: UIView!
    
    var viewModel: CompilationDetailViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        guard let viewModel = viewModel else  { return }
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        detailDescriptionLabel.text = viewModel.detailDescription
        imageView.kf.setImage(with: URL(string: viewModel.imageURL), placeholder: UIImage(named: "imagePlaceholder"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesTableView.delegate = self
        placesTableView.dataSource = self
        
        UISetup()
        
        
    }
    
    private func UISetup() {
        self.view.backgroundColor = ColorsCollection.defaultColor
        navView.backgroundColor = ColorsCollection.defaultColor
        placesTableView.backgroundColor = ColorsCollection.defaultColor
        
        nameLabel.font = UIFont(name: "SFUIText-Medium", size: 12) ?? UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = ColorsCollection.textGray
        
        descriptionLabel.font = UIFont(name: "SFUIText-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)
        descriptionLabel.textColor = ColorsCollection.textDarkGray
        
        detailDescriptionLabel.font = UIFont(name: "SFUIText-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)
        detailDescriptionLabel.textColor = ColorsCollection.textGray
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension CompilationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.numberOfRowOfPlaces() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceCell
        cell.viewModel = self.viewModel?.placeCellViewModel(for: indexPath)
        return cell
    }
    
    
}
