import UIKit

final class MainViewTC: BaseTC {
    var title: String
    var date: String
    var sponsor: String
    var id: Int
    var content: String
    init(
        title: String,
        date: String,
        sponsor: String,
        id: Int,
        content: String
    ) {
        self.title = title
        self.date = date
        self.sponsor = sponsor
        self.id = id
        self.content = content
        super.init(style: .default, reuseIdentifier: "Main")
    }
    private let backView = UIView().then {
        $0.backgroundColor = AttentionAsset.Assets.gray50.color
        $0.setShadow(radius: 8)
        $0.layer.cornerRadius = 8
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
        titleLabel.text = self.title
        dateLabel.text = self.date
        sponsorLabel.text = self.sponsor
        contentView.backgroundColor = AttentionAsset.Assets.gray50.color
        contentView.layer.cornerRadius = 8
        contentView.addSubview(backView)
        [
            titleLabel,
            dateLabel,
            sponsorLabel
        ].forEach { backView.addSubview($0) }
    }

    override func setLayout() {
        backView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.bottom.equalTo(-10)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.leading.trailing.equalTo(0).inset(15)
            $0.height.equalTo(24)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalTo(0).inset(15)
            $0.height.equalTo(24)
        }

        sponsorLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.trailing.equalTo(0).inset(15)
            $0.height.equalTo(24)
            $0.bottom.equalTo(-10)
        }
    }
}
