import UIKit
import SnapKit
import Then
extension UIView {
    func setShadow(radius: CGFloat) {
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.05
        self.layer.shadowRadius = radius
    }
}
