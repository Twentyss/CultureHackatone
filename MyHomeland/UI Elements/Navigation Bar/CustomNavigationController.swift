import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
    }
    
    private func UISetup() {
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = ColorsCollection.defaultColor
        navigationBar.layer.shadowColor = UIColor(red: 0.718, green: 0.734, blue: 0.817, alpha: 1).cgColor
        navigationBar.layer.shadowOpacity = 1
        navigationBar.layer.shadowRadius = 2
        navigationBar.layer.shadowOffset = CGSize(width: 2, height: 4)
        navigationBar.layer.cornerRadius = 10
        
        navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "SFUIText-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18),
                                              NSAttributedString.Key.foregroundColor: ColorsCollection.tintColor, NSAttributedString.Key.kern: -0.3 ]
        
        navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "SFUIText-Semibold", size: 24) ?? UIFont.systemFont(ofSize: 24),
                                                   NSAttributedString.Key.foregroundColor: ColorsCollection.tintColor, NSAttributedString.Key.kern: -0.3 ]
    }

}
