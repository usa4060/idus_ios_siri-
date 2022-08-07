
import Foundation
import Alamofire

// MARK: - OffLine
struct OffLine: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: OffLineResult
}


// MARK: - Result
struct OffLineResult: Codable {
    let classCategoryList: [ClassCategoryList]
    let userAddressName: String
    let nearOfflineClassList: [NearOfflineClassList]
    let newOpenOffLineClassesList: [NewOpenOffLineClassesList]
    
    enum CodingKeys: String, CodingKey {
        case newOpenOffLineClassesList = "newOpenClassesList"
        case userAddressName, classCategoryList, nearOfflineClassList
    }
}

// MARK: - ClassCategoryList
struct ClassCategoryList: Codable {
    let categoryID: Int
    let categoryName: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}


// MARK: - NearOfflineClassList
struct NearOfflineClassList: Codable {
    let offlineClassID: Int
    let imgURL, addressName, categoryName, title: String
    let rating : Float
    let countReview: Int

    enum CodingKeys: String, CodingKey {
        case offlineClassID = "offlineClassId"
        case imgURL = "imgUrl"
        case addressName, categoryName, title, rating, countReview
    }
}

// MARK: - NewOpenClassesList
struct NewOpenOffLineClassesList: Codable {
    let offlineClassID: Int
    let imgURL, addressName, categoryName, title: String

    enum CodingKeys: String, CodingKey {
        case offlineClassID = "offlineClassId"
        case imgURL = "imgUrl"
        case addressName, categoryName, title
    }
}
