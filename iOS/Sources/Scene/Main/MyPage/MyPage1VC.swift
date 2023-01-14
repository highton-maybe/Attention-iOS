import UIKit

class MyPageVC: BaseVC {
    var num = 0
    private let imageArr: [UIImage] = [
        AttentionAsset.Image.myPage3.image,
        AttentionAsset.Image.myPage5.image,
        AttentionAsset.Image.myPage4.image,
        AttentionAsset.Image.myPage0.image,
        AttentionAsset.Image.myPage1.image,
        AttentionAsset.Image.myPage2.image
    ]

    private let imageView = UIImageView()
    private let imageButton = UIButton()
    override func addView() {
        view.addSubview(imageView)
        view.addSubview(imageButton)
    }

    override func configureVC() {
        imageView.image = imageArr[num]

        imageButton.rx.tap.bind {
            if self.num == 5 {
                self.navigationController?.popViewController(animated: true)
            } else {
                let numx = self.num + 1
                self.num += 1
                self.imageView.image = self.imageArr[numx]

            }
        }.disposed(by: disposeBag)
    }

    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageButton.snp.makeConstraints {
            $0.edges.equalToSuperview()

        }
    }
}
