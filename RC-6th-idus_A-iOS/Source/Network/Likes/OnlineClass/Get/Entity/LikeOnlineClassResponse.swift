import Foundation
import Alamofire

// MARK: - LikeOfflineClass
struct LikeOnlineClass: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [LikeOnlineClassResult]
}

// MARK: - Result
struct LikeOnlineClassResult: Codable {
    let onlineClassID: Int
    let classImg, categoryName, level, title: String
    let writerName: String

    enum CodingKeys: String, CodingKey {
        case onlineClassID = "onlineClassId"
        case classImg, categoryName, level, title, writerName
    }
}
