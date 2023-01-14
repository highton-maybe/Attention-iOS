import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SignUpVC: BaseVC {
    private let viewModel = SignUpViewModel()
    private var passwordCheck = false
    private let logoImageView = UIImageView().then {
        $0.image = AttentionAsset.logo.image
    }
    private let signupLabel = UILabel().then {
        $0.text = "Sign up"
        $0.font = UIFont(font: AttentionFontFamily.Pretendard.bold, size: 25)
        $0.textColor = AttentionAsset.main.color
    }
    private let signUpScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.isScrollEnabled = false
    }
    private let signUpContentView = UIView()
    private let nameTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "Name")
        $0.addLeftPadding()
    }
    private let emailTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "E-mail")
        $0.addLeftPadding()
    }
    private let passwordTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "Password")
        $0.addLeftPadding()
        $0.isSecureTextEntry = true
    }
    private let passwordCheckTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "Password")
        $0.addLeftPadding()
        $0.isSecureTextEntry = true
    }
    private let passwordCheckImageView = UIImageView()
    private let phoneNumberTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "010-0000-0000")
        $0.addLeftPadding()
    }
    private let nextButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .black
    }
    private let backButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = AttentionAsset.main.color
    }
    private let majorTextView = UITextView().then {
        $0.setTextView(forTextView: $0, placeholderText: "분야를 적어주세요 ex) 기타, 보컬")
    }
    private let signupButton = UIButton(type: .system).then {
        $0.setAuthButton(forButton: $0, title: "Sign up", color: "Sub3")
        $0.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    override func configureVC() {
        nextButton.rx.tap.subscribe(onNext: { [self] in
            signUpScrollView.setContentOffset(CGPoint(x: view.frame.size.width, y: 0), animated: true)
        }).disposed(by: disposeBag)
        backButton.rx.tap.subscribe(onNext: { [self] in
            signUpScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }).disposed(by: disposeBag)
        signUpScrollView.rx.contentOffset
            .map { $0 == CGPoint(x: self.view.frame.width, y: 0) }
            .subscribe(onNext: {
                self.nextButton.isHidden = $0
                self.backButton.isHidden = !$0
            }).disposed(by: disposeBag)
        majorTextView.rx.didBeginEditing
            .subscribe(onNext: { [self] in
                if majorTextView.text == "분야를 적어주세요 ex) 기타, 보컬" {
                    majorTextView.text = ""
                    signupButton.isEnabled = true
                    signupButton.backgroundColor = AttentionAsset.main.color
                }
            }).disposed(by: disposeBag)
        passwordCheckTextField.rx.text
            .orEmpty
            .map { $0 != "" && $0 == self.passwordTextField.text }
            .subscribe(onNext: { [self] in
                passwordCheck = $0
                switch $0 {
                case true:
                    passwordCheckImageView.image = AttentionAsset.check.image
                default:
                    passwordCheckImageView.image = AttentionAsset.nocheck.image
                }
            }).disposed(by: disposeBag)
    }
    override func bind() {
        let input = SignUpViewModel.Input(
            name: nameTextField.rx.text.orEmpty.asDriver(),
            email: emailTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            passwordCheck: passwordCheckTextField.rx.text.orEmpty.asDriver(),
            phoneNumber: phoneNumberTextField.rx.text.orEmpty.asDriver(),
            major: majorTextView.rx.text.orEmpty.asDriver(),
            signupButtonDidTap: signupButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: { [self] in
            nextButton.isEnabled = $0
            signUpScrollView.isScrollEnabled = $0
            if $0 == true && passwordCheck {
                nextButton.tintColor = AttentionAsset.main.color
            }
        }).disposed(by: disposeBag)
        output.signUpResult.subscribe(onNext: { [self] in
            switch $0 {
            case true:
                self.navigationController?.popViewController(animated: true)
            default:
                print("회원가입 실패")
            }
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            logoImageView,
            signupLabel,
            signUpScrollView,
            nextButton,
            backButton
        ].forEach { view.addSubview($0) }
        signUpScrollView.addSubview(signUpContentView)
        signUpScrollView.contentSize = signUpContentView.frame.size
        [
            nameTextField,
            emailTextField,
            passwordTextField,
            passwordCheckTextField,
            phoneNumberTextField,
            majorTextView,
            signupButton
        ].forEach { signUpContentView.addSubview($0) }
        passwordCheckTextField.addSubview(passwordCheckImageView)
    }

    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(111)
            $0.width.equalTo(66.22)
            $0.height.equalTo(72.23)
            $0.centerX.equalToSuperview()
        }
        signupLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        signUpScrollView.snp.makeConstraints {
            $0.top.equalTo(signupLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(365)
            $0.width.equalToSuperview()
        }
        signUpContentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.width.equalTo(view.frame.width * 2)
            $0.height.equalToSuperview()
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalTo(view.frame.width / 2)
            $0.width.equalTo(345)
            $0.height.equalTo(49)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(25)
            $0.centerX.equalTo(view.frame.width / 2)
            $0.width.equalTo(345)
            $0.height.equalTo(49)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(25)
            $0.centerX.equalTo(view.frame.width / 2)
            $0.width.equalTo(345)
            $0.height.equalTo(49)
        }
        passwordCheckTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(25)
            $0.centerX.equalTo(view.frame.width / 2)
            $0.width.equalTo(345)
            $0.height.equalTo(49)
        }
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(25)
            $0.centerX.equalTo(view.frame.width / 2)
            $0.width.equalTo(345)
            $0.height.equalTo(49)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalTo(signUpScrollView.snp.bottom).offset(29)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(24)
        }
        majorTextView.snp.makeConstraints {
            $0.centerX.equalTo(view.frame.width / 2 + view.frame.width)
            $0.top.equalToSuperview().inset(10)
            $0.width.equalTo(345)
            $0.height.equalTo(194)
        }
        signupButton.snp.makeConstraints {
            $0.centerX.equalTo(view.frame.width / 2 + view.frame.width)
            $0.height.equalTo(49)
            $0.width.equalTo(345)
            $0.top.equalTo(majorTextView.snp.bottom).offset(18)
        }
        passwordCheckImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.trailing.bottom.equalToSuperview().inset(14)
            $0.width.equalTo(20)
        }
        backButton.snp.makeConstraints {
            $0.top.equalTo(signUpScrollView.snp.bottom).offset(29)
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(24)
        }
    }
}
