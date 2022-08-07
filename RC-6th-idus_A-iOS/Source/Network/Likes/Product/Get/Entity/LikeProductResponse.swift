import Foundation
import Alamofire

// MARK: - LikeProduct
struct LikeProduct: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [LikeProductResult]
}

// MARK: - Result
struct LikeProductResult: Codable {
    let productID: Int
    let imgURL, writerName, title: String
    let price, discountRate, finalPrice: Int
    let rating: Double
    let countReview: Int
    let lastReview: String?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case imgURL = "imgUrl"
        case writerName, title, price, discountRate, finalPrice, rating, countReview, lastReview
    }
}
