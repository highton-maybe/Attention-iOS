import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class LoginVC: BaseVC {
    private let logoImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    private let loginLabel = UILabel().then {
        $0.text = "Login"
        $0.font = UIFont(name: "Pretendard-Bold", size: 25)
    }
    private let emailTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "E-mail")
        $0.addLeftPadding()
    }
    private let passwordTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "Password")
        $0.addLeftPadding()
    }
    private let loginButton = UIButton(type: .system).then {
        $0.setAuthButton(forButton: $0, title: "Login", color: "Main")
    }
    private let signupButton = UIButton(type: .system).then {
        $0.setAuthButton(forButton: $0, title: "Sign up", color: "Gray200")
    }
    override func configureVC() {
        signupButton.rx.tap.bind {
            let vc = SignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func addView() {
        [
            logoImageView,
            loginLabel,
            emailTextField,
            passwordTextField,
            loginButton,
            signupButton
        ].forEach { self.view.addSubview($0) }
    }
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(111)
            $0.width.height.equalTo(74)
            $0.centerX.equalToSuperview()
        }
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(104)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        signupButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
    }
}
