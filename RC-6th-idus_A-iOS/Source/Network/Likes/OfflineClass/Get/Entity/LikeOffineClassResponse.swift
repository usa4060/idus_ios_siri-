import Foundation
import Alamofire

// MARK: - LikeOfflineClass
struct LikeOfflineClass: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [LikeOfflineClassResult]
}

// MARK: - Result
struct LikeOfflineClassResult: Codable {
    let offlineClassID: Int
    let classImg, addressName, categoryName, title: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case offlineClassID = "offlineClassId"
        case classImg, addressName, categoryName, title, price
    }
}
