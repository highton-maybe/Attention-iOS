import Foundation

struct Token {
    static var saveAccessToken: String?
    static var accessToken: String? {
        get {
           saveAccessToken = UserDefaults.standard.string(forKey: "accessToken")
           return saveAccessToken
        }

        set(newToken) {
            UserDefaults.standard.set(newToken, forKey: "accessToken")
            UserDefaults.standard.synchronize()
            saveAccessToken = UserDefaults.standard.string(forKey: "accessToken")
        }
    }

    static func removeToken() {
        accessToken = nil
    }
}

enum Header {
    case accessToken, tokenIsEmpty

    func header() -> [String: String]? {
        guard let token = Token.accessToken else {
            return ["Contect-Type": "application/json"]
        }

        switch self {
        case .accessToken:
            return ["Authorization": "Bearer " + token, "Contect-Type": "application/json"]
        case .tokenIsEmpty:
            return ["Contect-Type": "application/json"]
        }
    }
}
