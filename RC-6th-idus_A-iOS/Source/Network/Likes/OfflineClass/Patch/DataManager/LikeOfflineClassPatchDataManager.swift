import Foundation
import Alamofire

class LikeOfflineClassPatchDataManager{
    func LikeOfflineClassPatch( _ offClassId : Int, _ viewController : UIViewController, completion: @escaping (_ data: String) -> Void){
        var headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json",
                    "X-ACCESS-TOKEN" : Constant.USER_JWTTOKEN
        ]
        AF.request("\(Constant.BASE_URL)/offline-classes/\(Constant.USER_ID)/\(offClassId)/likes", method: .patch, parameters: nil ,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: LikeOfflineClassPatchRes.self){response in
                switch response.result {
                case .success(let response):
                    print("성공")
                    switch response.code{
                    case 1000:
                        completion(response.result)
                    case 2003:
                        completion("권한이 없는 유저의 접근입니다.")
                    case 3050:
                        completion("존재하지 않는 오프라인 클래스입니다.")
                    case 3331:
                        completion("오프라인 클래스 찜 상태가 아닙니다.")
                    default:
                        completion("데이터베이스 연결에 실패하였습니다 : 코드번호 \(response.code)")
                    }
                case .failure(let error):
                    print("회원가입 실패")
                    debugPrint(error)
                }

            }
        
    }
}
