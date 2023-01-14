import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SignUpVC: BaseVC {
    private let logoImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    private let loginLabel = UILabel().then {
        $0.text = "Sign up"
        $0.font = UIFont(name: "Pretendard-Bold", size: 25)
    }
    private let signUpScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
    }
    private let signUpContentView = UIView()
    private let pageControl = UIPageControl()
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
    }
    private let passwordCheckTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "E-Password")
        $0.addLeftPadding()
    }
    private let phoneNumberTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "010-0000-0000")
        $0.addLeftPadding()
    }
    private let nextButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = UIColor(named: "Chevron")
    }
    override func configureVC() {
        pageControl.addTarget(self, action: #selector(pageControlDidTap), for: .valueChanged)
        signUpScrollView.delegate = self
    }
    override func addView() {
        [
            logoImageView,
            loginLabel,
            signUpScrollView,
            nextButton,
            pageControl
        ].forEach { view.addSubview($0) }
        signUpScrollView.addSubview(signUpContentView)
        [
            nameTextField,
            emailTextField,
            passwordTextField,
            passwordCheckTextField,
            phoneNumberTextField
        ].forEach { signUpContentView.addSubview($0) }
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
        signUpScrollView.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(50)
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
        pageControl.snp.makeConstraints {
            $0.top.equalTo(signUpScrollView.snp.bottom).inset(10)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(30)
        }
    }
}
extension SignUpVC: UIScrollViewDelegate {
    private func setPageControl() {
        pageControl.numberOfPages = 2
    }
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == signUpScrollView {
            let value = scrollView.contentOffset.x/scrollView.bounds.size.width
            setPageControlSelectedPage(currentPage: Int(round(value)))
        }
    }
    @objc
    private func pageControlDidTap(_ sender: UIPageControl) {
        let current = sender.currentPage
        signUpScrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
}
