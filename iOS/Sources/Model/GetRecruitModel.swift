import Foundation

struct GetRecruitModel: Codable {
    let recruitId: Int
    let recruitTitle: String
    let recruitContent: String
    let recruitStartDate: String
    let recruitEndDate: String
    let organizerName: String
}
