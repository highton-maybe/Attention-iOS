//
//  baseVC.swift
//  solvedAC
//
//  Created by baegteun on 2021/10/29.
//

import UIKit
import RxSwift
class BaseVC: UIViewController {
    let bound = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Gray50")
        addView()
        setLayout()
        configureVC()
        bind()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

    func addView() {}
    func setLayout() {}
    func configureVC() {}
    func bind() {}
}
