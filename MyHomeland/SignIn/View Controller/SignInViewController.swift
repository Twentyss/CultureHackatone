import UIKit
import AuthenticationServices
import GoogleSignIn
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    
    var isInterfaceHidden = false {
        willSet {
            stackView.isHidden = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        SignIn.GoogleDelegate.shared.presentingViewController = self
        self.isInterfaceHidden = Auth.auth().currentUser != nil
    }
    
    private func setup() {
        let buttonsStackView = UIStackView()
        buttonsStackView.spacing = 8
        buttonsStackView.axis = .vertical
        if #available(iOS 13.0, *) {
            buttonsStackView.addArrangedSubview(self.appleButton())
        }
        buttonsStackView.addArrangedSubview(self.googleButton())
        
        stackView.addArrangedSubview(buttonsStackView)
    }
    
    @available(iOS 13.0, *)
    private func appleButton() -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.cornerRadius = 10
        button.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
        
        return button
    }
    
    private func googleButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setTitle(NSLocalizedString("Sign in with Google", comment: "Sign in with Google"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setImage(UIImage(named: "googleLogo"), for: .normal)
        button.titleEdgeInsets.left = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        
        return button
    }
    
    @available(iOS 13.0, *)
    @objc private func appleButtonTapped() {
        let delegate = SignIn.AppleDelegate.shared
        let rawNonce = delegate.generateRawNonce()
        delegate.currentRawNonce = rawNonce
        delegate.presentingViewController = self
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = delegate.sha256(rawNonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [ request ])
        authorizationController.delegate = delegate
        authorizationController.performRequests()
    }
    
    @objc private func googleButtonTapped() {
        GIDSignIn.sharedInstance()?.signIn()
    }

}
