import Foundation
import Alamofire

// MARK: - OrderList
struct OrderList: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [OrderListResult]
}


// MARK: - Result
struct OrderListResult: Codable {
    let productID: Int
    let orderAt: String
    let finalPrice: Int
    let productImg, title, writerName, sendStatus: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case orderAt, finalPrice, productImg, title, writerName, sendStatus
    }
}
