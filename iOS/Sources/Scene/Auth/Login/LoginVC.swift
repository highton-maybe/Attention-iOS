import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class LoginVC: BaseVC {
    private let viewModel = LoginViewModel()
    private let logoImageView = UIImageView().then {
        $0.image = AttentionAsset.logo.image
    }
    private let loginLabel = UILabel().then {
        $0.text = "Login"
        $0.font = UIFont(font: AttentionFontFamily.Pretendard.bold, size: 25)
        $0.textColor = AttentionAsset.main.color
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
    override func bind() {
        let input = LoginViewModel.Input(
            email: emailTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            loginButtonDidTap: loginButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            $0 ? print(Token.accessToken):print("로그인 실패")
        }).disposed(by: disposeBag)
    }
    override func configureVC() {
        signupButton.rx.tap.subscribe(onNext: {
            let signUpVC = SignUpVC()
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }).disposed(by: disposeBag)
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
            $0.width.equalTo(66.22)
            $0.height.equalTo(72.23)
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
