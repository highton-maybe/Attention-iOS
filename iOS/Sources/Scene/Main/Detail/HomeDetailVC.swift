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

    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: AttentionFontFamily.Pretendard.medium.name, size: 18.0)
        $0.textColor = AttentionAsset.Assets.gray900.color
    }

    private let dateLabel = UILabel().then {
        $0.font = UIFont(name: AttentionFontFamily.Pretendard.medium.name, size: 15.0)
        $0.textColor = AttentionAsset.Assets.gray400.color
    }

    private let sponsorLabel = UILabel().then {
        $0.font = UIFont(name: AttentionFontFamily.Pretendard.medium.name, size: 15.0)
        $0.textColor = AttentionAsset.Assets.gray300.color
    }

    private let line = UIView().then {
        $0.backgroundColor = AttentionAsset.Assets.gray100.color
    }

    private let contentTextView = UITextView().then {
        $0.font = UIFont(font: AttentionFontFamily.Pretendard.regular, size: 16)
    }

    override func addView() {
        [
            backImageView,
            backImageButton,
            titleLabel,
            dateLabel,
            sponsorLabel,
            line,
            contentTextView
        ].forEach { view.addSubview($0) }
    }

    override func setLayout() {
        backImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.height.equalTo(28)
            $0.leading.equalTo(24)
            $0.top.equalTo(12)
        }

        backImageButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

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
    }
}
