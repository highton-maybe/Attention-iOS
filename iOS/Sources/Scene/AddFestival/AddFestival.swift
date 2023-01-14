import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class AddFestival: BaseVC {
    private let viewModel = AddFestivalViewModel()
    private let titleTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "축제 이름")
        $0.addLeftPadding()
    }
    private let termTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "모집 기간")
        $0.addLeftPadding()
    }
    private let orderTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "주최자")
        $0.addLeftPadding()
    }
    private let detailTextView = UITextView().then {
        $0.setTextView(forTextView: $0, placeholderText: "상세 내용을 입력하세요.")
    }
    private let makeButton = UIButton(type: .system).then {
        $0.setAuthButton(forButton: $0, title: "축제 생성하기", color: "Main")
    }
    override func bind() {
        let input = AddFestivalViewModel.Input(
            title: titleTextField.rx.text.orEmpty.asDriver(),
            term: termTextField.rx.text.orEmpty.asDriver(),
            person: detailTextView.rx.text.orEmpty.asDriver(),
            buttonTap: makeButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                self.navigationController?.popViewController(animated: true)
            default:
                print("생성 실패 ")
            }
        }).disposed(by: disposeBag)
    }
    override func configureVC() {
        detailTextView.rx.didBeginEditing
            .subscribe(onNext: { [self] in
                if detailTextView.text == "상세 내용을 입력하세요." {
                    detailTextView.text = ""
                }
            }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            titleTextField,
            termTextField,
            orderTextField,
            detailTextView,
            makeButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        termTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        orderTextField.snp.makeConstraints {
            $0.top.equalTo(termTextField.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
        detailTextView.snp.makeConstraints {
            $0.top.equalTo(orderTextField.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(394)
        }
        makeButton.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
        }
    }
}
