
import Foundation
import Alamofire

struct GetAllProduct: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: List
}

struct List: Codable {
    let categoryProductList: [CategoryProductList]
    let productReviewList: [ProductReviewList]
}


struct CategoryProductList: Codable {
    let categoryID: Int
    let categoryName: String
    let productsList: [ProductsList]

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName, productsList
    }
}

struct ProductsList: Codable {
    let productID: Int
    let productImg: String
    let productTitle: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case productImg, productTitle
    }
}

struct ProductReviewList: Codable {
    let reviewID: Int
    let reviewImg: String
    let rating: Int
    let nickName, contents: String
    let productID: Int
    let productImg: String
    let productTitle: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case reviewImg, rating, nickName, contents
        case productID = "productId"
        case productImg, productTitle
    }
}
