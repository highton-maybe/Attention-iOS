import Foundation
import Moya

enum API {
    case login(email: String, password: String)
    case signUp(name: String, email: String, password: String, phoneNumber: String, major: String)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://5b08-118-129-228-11.jp.ngrok.io")!
    }

    var path: String {
        switch self {
        case .login:
            return "/member/login"
        case .signUp:
            return "/member/signup"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .signUp:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters:
                                        [
                                            "email": email,
                                            "password": password
                                        ], encoding: JSONEncoding.prettyPrinted)
        case .signUp(let name, let email, let password, let phoneNumber, let major):
            return .requestParameters(parameters:
                                        [
                                            "email": email,
                                            "password": password,
                                            "name": name,
                                            "phoneNumber": phoneNumber,
                                            "spacialty": major
                                        ], encoding: JSONEncoding.prettyPrinted)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login, .signUp:
            return Header.tokenIsEmpty.header()
        }
    }
}
