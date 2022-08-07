import Foundation
import Alamofire

// MARK: - OfflineClassDetail
struct BuyOption: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: BuyOptionResult
}

// MARK: - Result
struct BuyOptionResult: Codable {
    let productOptionList: [ProductOptionList]
}

// MARK: - ProductOptionList
struct ProductOptionList: Codable {
    let optionId: Int
    let optionName: String
    let optionDetailList: [OptionDetailList]
}

// MARK: - OptionDetailList
struct OptionDetailList: Codable {
    let optionDetailId: Int
    let optionDetailName: String
    let price: Int
}
