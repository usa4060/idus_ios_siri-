import Foundation
import Alamofire

// MARK: - OnlineClassDetail
struct OnlineClassDetail: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: OnlineClassDetailResult
}

// MARK: - Result
struct OnlineClassDetailResult: Codable {
    let videoURL: String
    let writerID: Int
    let writerImg, writerName, categoryName, title: String
    let streaming: Bool
    let startingDay, level: String
    let userLike: Bool
    let countLike, rating, countReview: Int
    let onlineClassReviewList: [OnlineClassReview]
    let contents: String
    let onlineClassCommentList: [OnlineClassComment]

    enum CodingKeys: String, CodingKey {
        case videoURL = "videoUrl"
        case writerID = "writerId"
        case writerImg, writerName, categoryName, title, streaming, startingDay, level, userLike, countLike, rating, countReview, onlineClassReviewList, contents, onlineClassCommentList
    }
}

struct OnlineClassReview : Codable {
    let reviewId : Int
    let reviewImg : String
    let userName : String
    let profileImg : String
    let createAt : String
    let contents : String
}

struct OnlineClassComment : Codable {
    let userName : String
    let userImg : String
    let userComment : String
    let writerName : String
    let writerImg : String
    let writerComment : String
}
