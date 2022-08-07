import Foundation
import Alamofire

class ProductDetatilDataManager{
    
    func requireProductDetail(_ productID : Int, _ viewController : UIViewController, _ completion: @escaping (_ data: ProductDetailInfoResult) -> Void){
        let headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json",
                    "X-ACCESS-TOKEN" : Constant.USER_JWTTOKEN
        ]
        
        AF.request("\(Constant.BASE_URL)/products/\(Constant.USER_ID)/\(productID)", method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ProductDetailInfo.self){response in
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
                    case 3030:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "권한이 없는  유저의 접근입니다.")
                        print("권한이 없는  유저의 접근입니다.")
                    case 4000:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "존재하지 않는 작품입니다.")
                        print("존재하지 않는 작품입니다.")
                    default:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "알 수 없는 에러가 발생하였습니다.")
                        print("알 수 없는 에러가 발생하였습니다. : 코드번호 \(response.code)")
                    }
                case .failure(let error):
                    print("제품 상세 화면 접속 실패")
                    print("제품 번호 : \(productID)")
                    print(error.localizedDescription)
                    debugPrint(error)
                }

            }
        
    }
}
