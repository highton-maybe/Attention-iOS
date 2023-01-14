import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class HomeDetailVC: BaseVC {
    private let backImageView = UIImageView().then {
        $0.image = AttentionAsset.Image.arrow.image
    }

    private let backImageButton = UIButton()

    let titleLabel = UILabel().then {
        $0.font = UIFont(name: AttentionFontFamily.Pretendard.medium.name, size: 18.0)
        $0.textColor = AttentionAsset.Assets.gray900.color
    }

    let dateLabel = UILabel().then {
        $0.font = UIFont(name: AttentionFontFamily.Pretendard.medium.name, size: 15.0)
        $0.textColor = AttentionAsset.Assets.gray400.color
    }

    let sponsorLabel = UILabel().then {
        $0.font = UIFont(name: AttentionFontFamily.Pretendard.medium.name, size: 15.0)
        $0.textColor = AttentionAsset.Assets.gray300.color
    }

    private let line = UIView().then {
        $0.backgroundColor = AttentionAsset.Assets.gray200.color
    }

    let contentTextView = UITextView().then {
        $0.font = UIFont(font: AttentionFontFamily.Pretendard.regular, size: 16)
    }

    let applyButton = UIButton(type: .system).then {
        $0.setTitle("오디션 신청하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        $0.layer.cornerRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        $0.layer.shadowOpacity = 0.05
        $0.layer.shadowRadius = 8
        $0.setTitleColor(AttentionAsset.Assets.gray25.color, for: .normal)
        $0.backgroundColor = AttentionAsset.Assets.main.color

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func configureVC() {
        applyButton.rx.tap.subscribe(onNext: {
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            titleLabel,
            dateLabel,
            sponsorLabel,
            line,
            contentTextView,
            applyButton
        ].forEach { view.addSubview($0) }
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(51)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(28)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(89)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(22)
        }

        sponsorLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(111)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(22)
        }

        line.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(146)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        applyButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(49)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}
