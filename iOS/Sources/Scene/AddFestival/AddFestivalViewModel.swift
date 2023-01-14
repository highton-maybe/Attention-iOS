import Foundation
import UIKit
import RxSwift
import RxCocoa

class AddFestivalViewModel: BaseVM {

    struct Input {
        let title: Driver<String>
        let term: Driver<String>
        let person: Driver<String>
        let buttonTap: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let info = Driver.combineLatest(input.title, input.term, input.person)
        input.buttonTap.asObservable()
            .withLatestFrom(info)
            .flatMap { title, term, person in
                api.addFestival(title, term, person)
            }.subscribe(onNext: {
                switch $0 {
                case .createOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(result: result)
    }
}
