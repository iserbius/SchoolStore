// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        localizable()
    }

    // MARK: Internal

    @IBOutlet var loginField: InputField!

    @IBOutlet var passwordField: InputField!

    @IBOutlet var signInButton: UIButton!

    func setup(with authService: AuthService) {
        self.authService = authService
    }

    @IBAction func signInPressed(_: Any) {
        guard let user = loginField.text, let password = passwordField.text else {
            return
        }
        if user.isEmpty {
            loginField.error = "Field is empty"
        } else if password != "pass", user != "user" {
            passwordField.error = "Auth failed"
        } else {
            authService?.authenticate(user: user, with: password, completion: { (result: Result<String, Error>) in
                guard case .success = result else {
                    return
                }
                UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildTabBarVC()
            })
        }
    }

    // MARK: Private

    private var authService: AuthService?

    private func localizable() {
        loginField.title = L10n.Auth.login
        passwordField.title = L10n.Auth.password
        signInButton.setTitle(L10n.Auth.action, for: .normal)
    }
}
