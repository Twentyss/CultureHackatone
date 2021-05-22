import AuthenticationServices
import FirebaseAuth
import CryptoKit

extension SignIn {
    
    @available(iOS 13.0, *)
    class AppleDelegate: NSObject, ASAuthorizationControllerDelegate {
        
        static let shared = AppleDelegate()
        
        var presentingViewController: UIViewController?
        
        var currentRawNonce: String?
        
        private override init() {}
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            guard let appleCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
            guard let idTokenData = appleCredential.identityToken else { return }
            guard let idToken = String(data: idTokenData, encoding: .utf8) else { return }
            guard let rawNonce = self.currentRawNonce else { return }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idToken, rawNonce: rawNonce)
            let name = appleCredential.fullName?.givenName ?? ""
            let surname = appleCredential.fullName?.familyName ?? ""
            let email = appleCredential.email ?? ""
            let authInfo = User.AuthInfo(name: name, surname: surname, email: email)
            SignIn.firebaseSignIn(credential: credential, authInfo: authInfo, presentingViewController: self.presentingViewController)
        }
        
        func generateRawNonce() -> String {
            let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
            var result = ""
            
            for _ in 0..<32 {
                result.append(charset.randomElement() ?? "0")
            }
            return result
        }
        
        func sha256(_ input: String) -> String {
            let inputData = Data(input.utf8)
            let hashedData = SHA256.hash(data: inputData)
            let hashString = hashedData.compactMap {
                return String(format: "%02x", $0)
            }.joined()

            return hashString
        }

    }
    
}
