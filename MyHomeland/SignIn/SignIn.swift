import FirebaseAuth
import SVProgressHUD

struct SignIn {
    
    private init() {}
    
    static func firebaseSignIn(credential: AuthCredential, authInfo: User.AuthInfo, presentingViewController: UIViewController?) {
        if presentingViewController != nil {
            SVProgressHUD.setContainerView(presentingViewController!.view)
        }
        SVProgressHUD.show()
        Auth.auth().signIn(with: credential) { (_, error) in
            if let _ = error {
                SVProgressHUD.dismiss()
                return
            }
            if let id = Auth.auth().currentUser?.uid, !authInfo.isEmpty {
                AppDatabase.shared.save(authInfo: authInfo, for: id)
            }
            let vc = TabBarController()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .flipHorizontal
            SVProgressHUD.dismiss()
            presentingViewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    static func firebaseSignOut() {
        try? Auth.auth().signOut()
    }
    
}
