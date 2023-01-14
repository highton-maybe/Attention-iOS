import Foundation
import Moya

enum API {
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "")!
    }

    var path: String {
        return ""
    }
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        return .requestParameters(parameters: ["df":"df"], encoding: URLEncoding.default)
    }

    var headers: [String: String]? {
        return Header.accessToken.header()
    }
}
