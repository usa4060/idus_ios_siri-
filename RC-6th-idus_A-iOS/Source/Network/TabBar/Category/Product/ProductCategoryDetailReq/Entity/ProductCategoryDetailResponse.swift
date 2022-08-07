
import Foundation
import Alamofire

// MARK: - ProductCaregoryDetail
struct ProductCaregoryDetail: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [ProductCaregoryDetailResult]
}

// MARK: - Result
struct ProductCaregoryDetailResult: Codable {
    let productID: Int
    let productImg: String
    let userLike: Bool
    let writerName, title: String
    let price, discountRate, finalPrice, rating: Int
    let countReview: Int
    let lastReview: String?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case productImg, userLike, writerName, title, price, discountRate, finalPrice, rating, countReview, lastReview
    }
}
