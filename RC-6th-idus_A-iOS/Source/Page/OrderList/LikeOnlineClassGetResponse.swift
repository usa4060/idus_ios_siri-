
import Foundation
import Alamofire

// MARK: - LikeOnlineClassGet
struct LikeOnlineClassGet: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [LikeOnlineClassGetResult]
}

// MARK: - Result
struct LikeOnlineClassGetResult: Codable {
    let onlineClassID: Int
    let classImg, categoryName, level, title: String
    let writerName: String

    enum CodingKeys: String, CodingKey {
        case onlineClassID = "onlineClassId"
        case classImg, categoryName, level, title, writerName
    }
}

