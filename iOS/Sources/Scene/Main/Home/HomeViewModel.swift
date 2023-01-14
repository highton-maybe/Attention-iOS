import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewModel: BaseVM {

    struct Input {
        let viewAppear: PublishRelay<Void>
        let schedule: Signal<Void>

    }
    struct Output {
        let recruit: BehaviorRelay<[GetRecruitModel]>
        let schedule: BehaviorRelay<[GetScheduleModel]>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let recruit = BehaviorRelay<[GetRecruitModel]>(value: [])
        let schedule = BehaviorRelay<[GetScheduleModel]>(value: [])

        input.viewAppear.asObservable()
            .flatMap { api.getRecruit() }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    recruit.accept(data)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        input.schedule.asObservable()
            .flatMap { api.getSchedule() }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    schedule.accept(data)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(recruit: recruit, schedule: schedule)
    }
}
