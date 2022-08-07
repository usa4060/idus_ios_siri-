
import Foundation
import Alamofire

// MARK: - ProductCaregoryRes
struct ProductCaregoryRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [ProductCategoryResult]
}

// MARK: - Result
struct ProductCategoryResult: Codable {
    let categoryID: Int
    let categoryName: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}

