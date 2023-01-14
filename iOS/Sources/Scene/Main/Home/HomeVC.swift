import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

enum HomeButtonType {
    case audition
    case festival
}

class HomeVC: BaseVC {
    private let buttonTypeRelay = BehaviorRelay<HomeButtonType>(value: .audition)

    private let logoImageView = UIImageView().then {
        $0.image = AttentionAsset.Image.typoLogo.image
    }

    private let profileImageView = UIImageView().then {
        $0.image = AttentionAsset.Image.biPeopleIocn.image
    }

    private let profileButton = UIButton()

    private let bannerScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }

    private let bannerContentView = UIView()

    private let bannerView1 = UIImageView().then {
        $0.image = AttentionAsset.Image.banner3.image
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    private let bannerView2 = UIImageView().then {
        $0.image = AttentionAsset.Image.banner2.image
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    private let bannerView3 = UIImageView().then {
        $0.image = AttentionAsset.Image.banner1.image
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }

    private let auditionButton = UIButton()
    private let festivalButton = UIButton()

    private let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
    }

    private let line = UIView().then {
        $0.backgroundColor = AttentionAsset.Assets.gray100.color
    }

    private let addButtonView = UIView().then {
        $0.setShadow(radius: 8)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = AttentionAsset.Assets.main.color
    }

    private let addButtonIcon = UIImageView().then {
        $0.image = AttentionAsset.Image.pencil.image
    }

    private let addButtonLabel = UILabel().then {
        $0.font = UIFont(name: AttentionFontFamily.Pretendard.semiBold.name, size: 14)
        $0.textColor = AttentionAsset.Assets.gray25.color
    }

    override func configureVC() {
        tableView.delegate = self
        tableView.dataSource = self
        auditionButton.setHomeButtonStatus(status: .selected, title: "오디션")
        festivalButton.setHomeButtonStatus(status: .none, title: "축제")

        profileButton.rx.tap.subscribe(onNext: {
            let signUpVC = MyPageVC()
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }).disposed(by: disposeBag)

        auditionButton.rx.tap.bind {
            self.buttonTypeRelay.accept(.audition)
        }.disposed(by: disposeBag)

        festivalButton.rx.tap.bind {
            self.buttonTypeRelay.accept(.festival)
        }.disposed(by: disposeBag)

        buttonTypeRelay.bind { type in
            if type == .festival {
                self.auditionButton.setHomeButtonStatus(status: .none, title: "오디션")
                self.festivalButton.setHomeButtonStatus(status: .selected, title: "축제")
                self.addButtonLabel.text = "일정 생성"
            }
            if type == .audition {
                self.auditionButton.setHomeButtonStatus(status: .selected, title: "오디션")
                self.festivalButton.setHomeButtonStatus(status: .none, title: "축제")
                self.addButtonLabel.text = "오디션 생성"
            }
        }.disposed(by: disposeBag)
    }

    override func addView() {
        [
            logoImageView,
            profileImageView,
            profileButton,
            bannerScrollView,
            auditionButton,
            festivalButton,
            line,
            tableView,
            addButtonView
        ].forEach { self.view.addSubview($0) }

        bannerScrollView.addSubview(bannerContentView)

        [
            bannerView1,
            bannerView2,
            bannerView3
        ].forEach { bannerContentView.addSubview($0) }

        [
            addButtonIcon,
            addButtonLabel
        ].forEach { addButtonView.addSubview($0) }
    }

    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            $0.leading.equalTo(19)
            $0.width.equalTo(113)
            $0.height.equalTo(31)
        }

        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.trailing.equalTo(-30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(23)
        }

        profileButton.snp.makeConstraints {
            $0.edges.equalTo(profileImageView)
        }

        bannerScrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(81)
            $0.height.equalTo(186)
        }

        bannerContentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview()
        }

        bannerView1.snp.makeConstraints {
            $0.height.equalTo(186)
            $0.width.equalTo(view.frame.width - 48)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(24)
        }

        bannerView2.snp.makeConstraints {
            $0.height.equalTo(186)
            $0.width.equalTo(view.frame.width - 48)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(bannerView1.snp.trailing).offset(12)
        }

        bannerView3.snp.makeConstraints {
            $0.height.equalTo(186)
            $0.width.equalTo(view.frame.width - 48)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(bannerView2.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(24)
        }

        auditionButton.snp.makeConstraints {
            $0.width.equalTo(69)
            $0.height.equalTo(36)
            $0.leading.equalTo(34)
            $0.top.equalTo(bannerScrollView.snp.bottom).offset(32)
        }

        festivalButton.snp.makeConstraints {
            $0.width.equalTo(69)
            $0.height.equalTo(36)
            $0.leading.equalTo(115)
            $0.top.equalTo(bannerScrollView.snp.bottom).offset(32)
        }

        line.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(350)
            $0.height.equalTo(1)
        }
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(354)
        }

        addButtonView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.trailing.equalTo(-24)
            $0.height.equalTo(56)
        }

        addButtonIcon.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }

        addButtonLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(18)
            $0.leading.equalTo(45)
            $0.trailing.equalTo(-20)
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return MainViewTC(title: "fnewjfenf", date: "2022-22-22", sponsor: "daehee")
    }
}
