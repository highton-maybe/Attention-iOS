import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya

final class Service {
    // swiftlint:disable line_length
    let provider = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])
    func login(_ email: String, _ password: String) -> Single<StatusCodeResult> {
        return provider.rx.request(.login(email: email, password: password))
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map { response -> StatusCodeResult in
                Token.accessToken = response.accessToken
                return .getOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func signUp(_ name: String, _ email: String,
                _ password: String, _ phoneNumber: String, _ major: String) -> Single<StatusCodeResult> {
        return provider.rx.request(.signUp(name: name, email: email, password: password, phoneNumber: phoneNumber, major: major))
            .filterSuccessfulStatusCodes()
            .map { _ -> StatusCodeResult in
                return .getOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func addFestival(_ title: String, _ term: String, _ person: String) -> Single<StatusCodeResult> {
        return provider.rx.request(.addFestival(title: title, content: person, date: term))
            .filterSuccessfulStatusCodes()
            .map { _ -> StatusCodeResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func addAutition(_ title: String, _ content: String, _ start: String, _ end: String) -> Single<StatusCodeResult> {
        return provider.rx.request(.addAudition(title: title, content: content, start: start, end: end))
            .filterSuccessfulStatusCodes()
            .map { _ -> StatusCodeResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func setNetworkError(_ error: Error) -> StatusCodeResult {
            print(error)
            print(error.localizedDescription)
            guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
            return (StatusCodeResult(rawValue: status) ?? .fault)
    }

}
