import GoogleSignIn
import FirebaseAuth

extension SignIn {
    
    class GoogleDelegate: NSObject, GIDSignInDelegate {
        
        static let shared = GoogleDelegate()
        
        var presentingViewController: UIViewController?
        
        private override init() {}
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if let _ = error { return }
            guard let auth = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
            let authInfo = User.AuthInfo(name: user.profile.givenName, surname: user.profile.familyName, email: user.profile.email)
            SignIn.firebaseSignIn(credential: credential, authInfo: authInfo, presentingViewController: self.presentingViewController)
        }
        
    }
    
}
