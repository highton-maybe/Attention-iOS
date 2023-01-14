import Foundation

struct GetScheduleModel: Codable {
    let scheduleID: Int
    let scheduleTitle, scheduleContent, scheduleDate, organizerName: String

    enum CodingKeys: String, CodingKey {
        case scheduleID = "scheduleId"
        case scheduleTitle, scheduleContent, scheduleDate, organizerName
    }
}
