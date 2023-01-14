import UIKit
import SnapKit
import Then
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
}
