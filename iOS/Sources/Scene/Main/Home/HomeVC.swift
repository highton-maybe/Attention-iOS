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
    var titles = ["복면가왕", "대덕소프트웨어 마이스터고 축제", "길거리에서 저랑 노래하실 분!", "대구소프트웨어 마이스터고 축제"]
    var dates = ["모집 일시 : 2022-10-11 ~ 2022-11-11", "모집 일시 : 2022-10-11 ~ 2022-11-11", "모집 일시 : 2022-10-11 ~ 2022-11-11", "모집 일시 : 2022-10-11 ~ 2022-11-11"]
    var soponser = ["넥슨", "카카오", "네이버", "다음"]
    var contents = ["대덕소프트웨어마이스터고등학교에서 청죽제를 하기로 했습니다!!\n그 중에서도 저희가 아주 심혈을 기울여 만들고 있는 복면가왕의\n참가자를 모집합니다!!!\n참가조건 : 대덕소프트웨어마이스터 고등학교 학생\n장소 : 대덕소프트웨어마이스터고등학교 청죽관",
        "대덕소프트웨어마이스터고등학교에서 청죽제를 하기로 했습니다!!\n그 중에서도 저희가 아주 심혈을 기울여 만들고 있는 복면가왕의\n참가자를 모집합니다!!!\n참가조건 : 대덕소프트웨어마이스터 고등학교 학생\n장소 : 대덕소프트웨어마이스터고등학교 청죽관",
        "대덕소프트웨어마이스터고등학교에서 청죽제를 하기로 했습니다!!\n그 중에서도 저희가 아주 심혈을 기울여 만들고 있는 복면가왕의\n참가자를 모집합니다!!!\n참가조건 : 대덕소프트웨어마이스터 고등학교 학생\n장소 : 대덕소프트웨어마이스터고등학교 청죽관",
        "대덕소프트웨어마이스터고등학교에서 청죽제를 하기로 했습니다!!\n그 중에서도 저희가 아주 심혈을 기울여 만들고 있는 복면가왕의\n참가자를 모집합니다!!!\n참가조건 : 대덕소프트웨어마이스터 고등학교 학생\n장소 : 대덕소프트웨어마이스터고등학교 청죽관"]
    private let viewModel = HomeViewModel()
    private let viewAppear = PublishRelay<Void>()
    private let buttonTypeRelay = BehaviorRelay<HomeButtonType>(value: .audition)
    private var vcType = ""
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
        $0.register(MainViewTC.self, forCellReuseIdentifier: "Main")
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

    private let addButton = UIButton()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        viewAppear.accept(())
    }

    override func configureVC() {
        Token.accessToken = nil
        if Token.accessToken == nil {
            let loginVC = BaseNC(rootViewController: LoginVC())
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
        }
        tableView.delegate = self
        tableView.dataSource = self
        auditionButton.setHomeButtonStatus(status: .selected, title: "오디션")
        festivalButton.setHomeButtonStatus(status: .none, title: "축제")

        profileButton.rx.tap.subscribe(onNext: {
            let signUpVC = MyPageVC()
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }).disposed(by: disposeBag)

        auditionButton.rx.tap.bind { [self] in
            self.titles = ["복면가왕", "대덕소프트웨어 마이스터고 축제", "길거리에서 저랑 노래하실 분!", "대구소프트웨어 마이스터고 축제"]
            self.soponser = ["넥슨", "카카오", "네이버", "다음"]
            tableView.reloadData()
            self.buttonTypeRelay.accept(.audition)
        }.disposed(by: disposeBag)
        festivalButton.rx.tap.bind { [self] in
            self.titles = ["길거리에서 저랑 노래하실 분!", "마이스터고 축제", "복면가왕", "대구 축제"]
            self.soponser = ["다음", "네이버", "카카오", "넥슨"]
            tableView.reloadData()
            self.buttonTypeRelay.accept(.festival)
        }.disposed(by: disposeBag)
        addButton.rx.tap.subscribe(onNext: { [self] in
            if vcType == "festival" {
                let detailVC = AddFestivalVC()
                self.navigationController?.pushViewController(detailVC, animated: true)
            } else {
                let detailVC = AddAuditionVC()
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }).disposed(by: disposeBag)
        buttonTypeRelay.bind { [self] in
            if $0 == .festival {
                auditionButton.setHomeButtonStatus(status: .none, title: "오디션")
                festivalButton.setHomeButtonStatus(status: .selected, title: "축제")
                addButtonLabel.text = "일정 생성"
                vcType = "festival"
            }
            if $0 == .audition {
                auditionButton.setHomeButtonStatus(status: .selected, title: "오디션")
                festivalButton.setHomeButtonStatus(status: .none, title: "축제")
                addButtonLabel.text = "오디션 생성"
                vcType = "audition"
            }
        }.disposed(by: disposeBag)
    }
    override func bind() {
//        let input = HomeViewModel.Input(viewAppear: viewAppear, schedule: festivalButton.rx.tap.asSignal())
//        let output = viewModel.transform(input)
//        output.schedule.bind(to: scheduleTableView.rx.items(cellIdentifier: "Main", cellType: MainViewTC.self)) { _, item, cell in
//            cell.title = item.scheduleTitle
//            cell.date = item.scheduleDate
//            cell.sponsor = item.organizerName
//            cell.id = item.scheduleID
//            cell.content = item.scheduleContent
//        }.disposed(by: disposeBag)
//        output.recruit.bind(to: tableView.rx.items(cellIdentifier: "Main2", cellType: MainViewTC.self)) { _, item, cell in
//            cell.title = item.recruitTitle
//            cell.date = "\(item.recruitStartDate) ~ \(item.recruitEndDate)"
//            cell.sponsor = item.organizerName
//            cell.id = item.recruitId
//            cell.content = item.recruitContent
//        }.disposed(by: disposeBag)
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
        addButtonView.addSubview(addButton)
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

        addButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return MainViewTC(title: titles[indexPath.row], date: dates[indexPath.row], sponsor: soponser[indexPath.row], id: 0, content: contents[indexPath.row])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? MainViewTC
        let homeDetailVC = HomeDetailVC()

        self.buttonTypeRelay.bind { index in
            if index == .festival {
                homeDetailVC.applyButton.isHidden = true
            }
        }.disposed(by: disposeBag)
        homeDetailVC.titleLabel.text = cell?.title
        homeDetailVC.sponsorLabel.text = cell?.sponsor
        homeDetailVC.dateLabel.text = cell?.date
        homeDetailVC.contentTextView.text = cell?.content
        self.navigationController?.pushViewController(homeDetailVC, animated: true)

    }
}
