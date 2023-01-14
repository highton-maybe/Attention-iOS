import Foundation
import UIKit
import RxSwift
import RxCocoa

class SignUpViewModel: BaseVM {

    struct Input {
        let name: Driver<String>
        let email: Driver<String>
        let password: Driver<String>
        let passwordCheck: Driver<String>
        let phoneNumber: Driver<String>
        let major: Driver<String>
        let signupButtonDidTap: Signal<Void>
    }
    struct Output {
        let result: BehaviorRelay<Bool>
        let signUpResult: PublishRelay<Bool>
        let textsResult: BehaviorRelay<Bool>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = BehaviorRelay<Bool>(value: false)
        let textsResult = BehaviorRelay<Bool>(value: false)
        let signUpResult = PublishRelay<Bool>()
        let textField = Driver
            .combineLatest(input.name, input.email, input.password, input.passwordCheck, input.phoneNumber)
        let text = Driver
            .combineLatest(input.name, input.email, input.password, input.phoneNumber, input.major)
        let info = Driver
            .combineLatest(input.name, input.email, input.password, input.phoneNumber, input.major)
        textField.asObservable()
            .map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty && !$0.3.isEmpty && !$0.4.isEmpty }
            .bind(onNext: {
                result.accept($0)
            }).disposed(by: disposeBag)
        text.asObservable()
            .map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty && !$0.3.isEmpty && !$0.4.isEmpty }
            .bind(onNext: {
                textsResult.accept($0)
            }).disposed(by: disposeBag)
        input.signupButtonDidTap.asObservable()
            .withLatestFrom(info)
            .flatMap { name, email, password, phoneNumber, major in
                api.signUp(name, email, password, phoneNumber, major)
            }.subscribe(onNext: {
                switch $0 {
                case .getOk:
                    signUpResult.accept(true)
                default:
                    signUpResult.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(result: result, signUpResult: signUpResult, textsResult: textsResult)
    }
}
