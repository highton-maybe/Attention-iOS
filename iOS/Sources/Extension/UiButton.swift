import UIKit
import SnapKit
import Then

enum HomeButtonStatusType {
    case selected
    case none
}

extension UIButton {
    func setAuthButton(forButton: UIButton, title: String, color: String) {
        forButton.backgroundColor = UIColor(named: color)
        forButton.setTitle(title, for: .normal)
        forButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        forButton.setTitleColor(UIColor(named: "Gray25"), for: .normal)
        forButton.layer.cornerRadius = 8
        forButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        forButton.layer.shadowOpacity = 0.05
        forButton.layer.shadowRadius = 8
    }

    func setHomeButtonStatus(status: HomeButtonStatusType, title: String) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.05
        self.layer.shadowRadius = 8

        if status == .selected {
            self.setTitleColor(AttentionAsset.Assets.gray25.color, for: .normal)
            self.backgroundColor = AttentionAsset.Assets.main.color
        }
        if status == .none {
            self.setTitleColor(AttentionAsset.Assets.gray400.color, for: .normal)
            self.backgroundColor = AttentionAsset.Assets.gray50.color
            self.layer.borderWidth = 1
            self.layer.borderColor = AttentionAsset.Assets.gray400.color.cgColor
        }
    }
}
