import Foundation
import Alamofire

class ProductCategoryDetailReqDataManager{
    func requireProductCategoryDetail(_ categoryID : Int ,_ viewController : UIViewController, _ completion: @escaping (_ data: [ProductCaregoryDetailResult]) -> Void){
        var headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json",
                    "X-ACCESS-TOKEN" : Constant.USER_JWTTOKEN
        ]
        AF.request("\(Constant.BASE_URL)/products/\(Constant.USER_ID)/categories/\(categoryID)?img=0", method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ProductCaregoryDetail.self){response in
                switch response.result {
                case .success(let response):
                    print("성공")
                    switch response.code{
                    case 1000:
                        completion(response.result)
                    case 2003:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "권한이 없는  유저의 접근입니다.")
                        print("권한이 없는  유저의 접근입니다.")
                   default:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "데이터베이스 연결에 실패하였습니다")
                        print("데이터베이스 연결에 실패하였습니다")
                    }
                case .failure(let error):
                    print("로그인 실패")
                    print(error.localizedDescription)
                }

            }
        
    }
}
