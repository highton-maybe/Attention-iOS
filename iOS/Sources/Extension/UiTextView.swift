import UIKit
import SnapKit
import Then
extension UITextView {
    func setTextView(forTextView: UITextView, placeholderText: String) {
        forTextView.attributedText = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Gray600")!]
        )
        forTextView.font = UIFont(font: AttentionFontFamily.Pretendard.regular, size: 16)
        forTextView.layer.cornerRadius = 8
        forTextView.layer.borderWidth = 1
        forTextView.layer.borderColor = UIColor(named: "Gray200")?.cgColor
        forTextView.layer.shadowColor = UIColor.black.cgColor
        forTextView.layer.shadowOffset = CGSize(width: 0, height: 1)
        forTextView.layer.shadowOpacity = 0.05
        forTextView.layer.shadowRadius = 8
        forTextView.backgroundColor = UIColor(named: "Gray50")
    }
}
