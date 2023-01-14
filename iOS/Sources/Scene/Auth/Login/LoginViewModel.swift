import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewModel: BaseVM {

    struct Input {
        let email: Driver<String>
        let password: Driver<String>
        let loginButtonDidTap: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let info = Driver.combineLatest(input.email, input.password)
        input.loginButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap { email, password in
                api.login(email, password)
            }.subscribe(onNext: {
                switch $0 {
                case .getOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(result: result)
    }
}
