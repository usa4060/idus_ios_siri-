import Foundation
import Alamofire

class OnLineDataManager{
    func requireOnLine(_ viewController : UIViewController, _ completion: @escaping (_ data: OnLineResult) -> Void){
        var headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json",
                    "X-ACCESS-TOKEN" : Constant.USER_JWTTOKEN
        ]
        
        AF.request("\(Constant.BASE_URL)/online-classes/\(Constant.USER_ID)", method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: OnLine.self){response in
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
