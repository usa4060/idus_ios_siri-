import Foundation
import Alamofire


struct ProductDetailInfo: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ProductDetailInfoResult
    
}



struct ProductDetailInfoResult: Codable {
    let imgUrlList: [String]
    let writerId: Int
    let writerName: String
    let profileImg: String?
    let rating: Double
    let countReview: Int
    let title: String
    let price, discountRate, finalPrice: Int
    let shortReviewList: [ShortReviewList]?
    let countBuyer, deliveryFee, freeAmount, leftAmount: Int
    let contents: String
    let reviewList: [ReviewList]?
    let commentList: [CommentList]?
    let ratingAverage: Double
    let countAllReview, countAllLike, countFollow, countSupport: Int
    let countProductLike: Int
    let like: Bool
    
//    enum CodingKeys: String, CodingKey {
//        case imgURLList = "imgUrlList"
//        case writerID = "writerId"
//        case writerName, profileImg, rating, countReview, title, price, discountRate, finalPrice, shortReviewList, countBuyer, deliveryFee, freeAmount, leftAmount, contents, reviewList, commentList, ratingAverage, countAllReview, countAllLike, countFollow, countSupport, countProductLike, like
//    }
}

struct CommentList: Codable {
    let userName: String?
    let userProfileImg: String?
    let userComment: String?
    let writerName: String?
    let writerProfileImg: String?
    let writerComment: String?
}

struct ReviewList: Codable {
    let reviewId: Int
    let nickName: String
    let profileImg: String?
    let rating: Int
    let createAt: String
    let repurchase: Bool
    let reviewImg: String?
    let contents: String?
    
//    enum CodingKeys: String, CodingKey {
//        case reviewID = "reviewId"
//        case nickName, profileImg, rating, createAt, repurchase, reviewImg, contents
//    }
}
struct ShortReviewList: Codable {
    let repurchase: Bool
    let imgUrl: String?
    let contents: String?
    
//    enum CodingKeys: String, CodingKey {
//        case repurchase
//        case imgURL = "imgUrl"
//        case contents
//    }
}
