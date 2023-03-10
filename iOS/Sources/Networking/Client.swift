import Foundation
import Moya

enum API {
    case login(email: String, password: String)
    case signUp(name: String, email: String, password: String, phoneNumber: String, major: String)
    case addFestival(title: String, content: String, date: String)
    case addAudition(title: String, content: String, start: String, end: String)
    case getAudition
    case getFestival
    case postAudtition(recruitId: Int)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://7980-118-129-228-11.jp.ngrok.io")!
    }

    var path: String {
        switch self {
        case .login:
            return "/member/login"
        case .signUp:
            return "/member/signup"
        case .addFestival:
            return "/schedule"
        case .addAudition:
            return "/recruit"
        case .getAudition:
            return "/recruit"
        case .getFestival:
            return "/schedule"
        case .postAudtition(let recruitId):
            return "/schedule/\(recruitId)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .signUp, .addFestival, .addAudition, .postAudtition:
            return .post
        case .getAudition, .getFestival:
            return .get
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
                                            "specialty": major
                                        ], encoding: JSONEncoding.prettyPrinted)
        case .addFestival(let title, let content, let date):
            return .requestParameters(parameters:
                                        [
                                            "scheduleTitle": title,
                                            "scheduleContent": content,
                                            "scheduleDate": date
                                        ], encoding: JSONEncoding.prettyPrinted)
        case .addAudition(let title, let content, let start, let end):
            return .requestParameters(parameters:
                                        [
                                            "recruitTitle": title,
                                            "recruitContent": content,
                                            "recruitStartDate": start,
                                            "recruitEndDate": end
                                        ], encoding: JSONEncoding.prettyPrinted)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login, .signUp:
            return Header.tokenIsEmpty.header()
        case .addFestival, .addAudition, .getAudition, .getFestival, .postAudtition:
            return Header.accessToken.header()
        }
    }
}
