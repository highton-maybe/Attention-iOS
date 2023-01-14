import UIKit

final class MainViewTC: BaseTC {
    private let title: String
    private let date: String
    private let sponsor: String

    init(
        title: String,
        date: String,
        sponsor: String
    ) {
        self.title = title
        self.date = date
        self.sponsor = sponsor
        super.init(style: .default, reuseIdentifier: "Main")
    }

    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: AttentionFontFamily.Pretendard.medium.name, size: 15.0)
        $0.textColor = AttentionAsset.Assets.gray800.color
    }

    private let dateLabel = UILabel().then {
        $0.font = UIFont(name: AttentionFontFamily.Pretendard.medium.name, size: 14.0)
        $0.textColor = AttentionAsset.Assets.gray400.color
    }

    private let sponsorLabel = UILabel().then {
        $0.font = UIFont(name: AttentionFontFamily.Pretendard.medium.name, size: 14.0)
        $0.textColor = AttentionAsset.Assets.gray300.color
    }

    override func configureVC() {
        contentView.backgroundColor = AttentionAsset.Assets.gray50.color
        contentView.layer.cornerRadius = 8
        contentView.setShadow(radius: 8)
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(24)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(24)
        }

        sponsorLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(24)
        }
    }
}
