import Foundation
import UIKit
import RxSwift
import RxCocoa

class AddAuditionViewModel: BaseVM {

    struct Input {
        let title: Driver<String>
        let startTerm: Driver<String>
        let endTerm: Driver<String>
        let content: Driver<String>
        let buttonTap: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let info = Driver.combineLatest(input.title, input.startTerm, input.endTerm, input.content)
        input.buttonTap.asObservable()
            .withLatestFrom(info)
            .flatMap { title, start, end, content in
                api.addAutition(title, content, start, end)
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
