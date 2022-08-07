// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let classCaregoryRes = try? newJSONDecoder().decode(ClassCaregoryRes.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseClassCaregoryRes { response in
//     if let classCaregoryRes = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - ClassCaregoryRes
struct ClassCaregoryRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ClassCategoryResult
}

// MARK: - Result
struct ClassCategoryResult: Codable {
    let categoryList: [CategoryList]
    let addressList: [AddressList]
}

// MARK: - AddressList
struct AddressList: Codable {
    let addressID: Int
    let addressName: String

    enum CodingKeys: String, CodingKey {
        case addressID = "addressId"
        case addressName
    }
}

// MARK: - CategoryList
struct CategoryList: Codable {
    let categoryID: Int
    let categoryName: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}
