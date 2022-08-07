
import Foundation
import Alamofire

// MARK: - RealTime
struct RealTime: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let lookUpTime: String
    let realTimeProducts: [RealTimeProduct]
}

// MARK: - RealTimeProduct
struct RealTimeProduct: Codable {
    let productID: Int
    let imgURL, writerName, title: String
    let rating: Double
    let countReview: Int
    let reviewContents: String?
    let like: Bool

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case imgURL = "imgUrl"
        case writerName, title, rating, countReview, reviewContents, like
    }
}

