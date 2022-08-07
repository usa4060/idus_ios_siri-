

import Foundation
import Alamofire

struct OnLine: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: OnLineResult
}

struct OnLineResult: Codable {
    let bestReviewList: [BestReviewList]
    let newOpenClassesList: [NewOpenClassesList]
    let userLikeClassesList: [UserLikeClassesList]
    let allOnlineClassesList: [AllOnlineClassesList]
}

struct AllOnlineClassesList: Codable {
    let classID: Int
    let profileImg, categoryName, writerName, classTitle: String
    let reviewRating: Int
    let userName, contents: String?
    let like, streaming: Bool

    enum CodingKeys: String, CodingKey {
        case classID = "classId"
        case profileImg, categoryName, writerName, classTitle, reviewRating, userName, contents, like, streaming
    }
}

struct BestReviewList: Codable {
    let onlineClassReviewID: Int
    let reviewImg: String
    let rating: Int
    let nickName, contents: String
    let classID: Int
    let classImg, classTitle: String

    enum CodingKeys: String, CodingKey {
        case onlineClassReviewID = "onlineClassReviewId"
        case reviewImg, rating, nickName, contents
        case classID = "classId"
        case classImg, classTitle
    }
}

struct NewOpenClassesList: Codable {
    let classID: Int
    let profileImg, categoryName, writerName, title: String
    let like, streaming: Bool

    enum CodingKeys: String, CodingKey {
        case classID = "classId"
        case profileImg, categoryName, writerName, title, like, streaming
    }
}

struct UserLikeClassesList: Codable {
    let classID: Int
    let profileImg, categoryName, writerName, classTitle: String

    enum CodingKeys: String, CodingKey {
        case classID = "classId"
        case profileImg, categoryName, writerName, classTitle
    }
}
