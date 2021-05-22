import UIKit
import SVProgressHUD
import FirebaseAuth

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let compilationStoryboard = UIStoryboard(name: "Compilation", bundle: nil)
        let eventsStoryboard = UIStoryboard(name: "Events", bundle: nil)
        guard let compilationVC = compilationStoryboard.instantiateInitialViewController() else { return }
        guard let profileVC = profileStoryboard.instantiateInitialViewController() else { return }
        guard let eventsVC = eventsStoryboard.instantiateInitialViewController() else { return }
        self.viewControllers = [ compilationVC, eventsVC, profileVC ]
        if let items = self.tabBar.items {
            items[0].image = UIImage(named: "compilation.tabbaritem")
            items[0].selectedImage = UIImage(named: "compilationSelected")
            items[0].imageInsets.bottom = -9
            
            items[1].image = UIImage(named: "events.tabbaritem")
            items[1].selectedImage = UIImage(named: "eventsSelected")
            items[1].imageInsets.bottom = -9
            
            items[2].image = UIImage(named: "profile.tabbaritem")
            items[2].selectedImage = UIImage(named: "profileSelected")
            items[2].imageInsets.bottom = -9
        }
        
        
        if let id = Auth.auth().currentUser?.uid {
            SVProgressHUD.setContainerView(self.view)
            SVProgressHUD.show()
            AppDatabase.shared.observe(userWith: id) { (user) in
                User.currentSubject.onNext(user)
                SVProgressHUD.dismiss()
            }
        }
    }
    
}
