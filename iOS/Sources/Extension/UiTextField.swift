import UIKit
import SnapKit
import Then
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func setTextField(forTextField: UITextField, placeholderText: String) {
        forTextField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Gray600")!]
        )
        forTextField.font = UIFont(font: AttentionFontFamily.Pretendard.regular, size: 16)
        forTextField.layer.cornerRadius = 8
        forTextField.layer.borderWidth = 1
        forTextField.layer.borderColor = UIColor(named: "Gray200")?.cgColor
        forTextField.layer.shadowColor = UIColor.black.cgColor
        forTextField.layer.shadowOffset = CGSize(width: 0, height: 1)
        forTextField.layer.shadowOpacity = 0.05
        forTextField.layer.shadowRadius = 8
        forTextField.backgroundColor = UIColor(named: "Gray50")
    }
}
