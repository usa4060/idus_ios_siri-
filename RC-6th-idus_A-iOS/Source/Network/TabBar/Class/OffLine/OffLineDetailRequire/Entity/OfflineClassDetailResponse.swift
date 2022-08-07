import Foundation
import Alamofire

// MARK: - OfflineClassDetail
struct OfflineClassDetail: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: OfflineClassDetailResult
}

// MARK: - Result
struct OfflineClassDetailResult: Codable {
    let classImgList: [String]
    let categoryName, title: String
    let price, discountRate, finalPrice: Int
    let level, timeSpend, maxCapacity: String
    let userLike: Bool
    let countLike, writerID: Int
    let writerImg, writerName, contents, addressName: String
    let classReviewsList : [OfflineClassReview]
    let classCommentList: [OfflineClassComment]

    enum CodingKeys: String, CodingKey {
        case classImgList, categoryName, title, price, discountRate, finalPrice, level, timeSpend, maxCapacity, userLike, countLike
        case writerID = "writerId"
        case writerImg, writerName, contents, addressName, classReviewsList, classCommentList
    }
}

struct OfflineClassReview : Codable {
    let reviewId : Int
    let reviewImg : String?
    let userName : String
    let profileImg : String?
    let createAt : String
    let contents : String?
}

struct OfflineClassComment : Codable {
    let userName : String
    let userImg : String?
    let userComment : String?
    let writerName : String
    let writerImg : String?
    let writerComment : String?
}
