import Foundation
import Alamofire

// MARK: - New
struct NewProduct: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: NewResult
}

struct NewResult: Codable {
    let lookUpTime: String
    let newProductsList: [NewProductsList]
}

struct NewProductsList: Codable {
    let productID: Int
    let imgURL, writerName, title: String
    let price, discountRate, finalPrice: Int
    let like, freeDelivery: Bool

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case imgURL = "imgUrl"
        case writerName, title, price, discountRate, finalPrice, like, freeDelivery
    }
}
