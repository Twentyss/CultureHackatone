import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth
import SVProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GIDSignIn.sharedInstance()?.clientID = "167215323833-cki3vf1aknsmgi504fgdljv5brh54lpc.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = SignIn.GoogleDelegate.shared
        FirebaseApp.configure()
        SVProgressHUD.setForegroundColor(ColorsCollection.tintColor)
        if #available(iOS 13.0, *) {} else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.tintColor = ColorsCollection.tintColor
            let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
            self.window?.rootViewController = storyboard.instantiateInitialViewController()
            self.window?.makeKeyAndVisible()
            if Auth.auth().currentUser != nil {
                let vc = TabBarController()
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .flipHorizontal
                self.window?.rootViewController?.present(vc, animated: false, completion: nil)
            }
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}

