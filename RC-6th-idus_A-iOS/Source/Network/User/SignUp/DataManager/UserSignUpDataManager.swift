import Foundation
import Alamofire

class UserSignUpDataManager{
    func signUpUser(_ email : String, _ name : String, _ password : String , _ phoneNumber : String , _ viewController : SignUpViewController, completion: @escaping (_ data: SignUpResult) -> Void){
        var headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json"
        ]
        var param : Parameters = [
                "email" : "\(email)",
                "name" : "\(name)",
                "password" : "\(password)",
                "phoneNumber" : "\(phoneNumber)"
        ]
        
        AF.request("\(Constant.BASE_URL)/users", method: .post, parameters: param ,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: SignUpRes.self){response in
                switch response.result {
                case .success(let response):
                    print("성공")
                    switch response.code{
                    case 1000:
                        completion(response.result ?? SignUpResult(jwt: "", userID: 0))
                    case 2020:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "이메일을 입력해주세요")
                        print("이메일을 입력해주세요")
                    case 2021:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "이메일 형식을 확인해주세요")
                        print("이메일 형식을 확인해주세요")
                    case 2022:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "이메일 길이를 확인해주세요")
                        print("이메일 길이를 확인해주세요")
                    case 2030:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "휴대폰 번호를 입력해주세요")
                        print("휴대폰 번호를 입력해주세요")
                    case 2031:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "잘못된 휴대폰 번호입니다")
                        print("잘못된 휴대폰 번호입니다")
                    case 2040:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "이름을 입력해주세요")
                        print("이름을 입력해주세요")
                    case 2041:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "이름은 최대 20자까지 입력해주세요")
                        print("이름은 최대 20자까지 입력해주세요")
                    case 2050:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "비밀번호를 입력해주세요")
                        print("비밀번호를 입력해주세요")
                    case 2051:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "비밀번호는 영문+숫자+특수문자 8자 이상입니다")
                        print("비밀번호는 영문+숫자+특수문자 8자 이상입니다")
                    case 3010:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "중복된 이메일입니다")
                        print("중복된 이메일입니다")
                    case 3020:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "중복된 휴대폰 번호입니다")
                        print("중복된 휴대폰 번호입니다")
                    case 4000:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "데이터베이스 연결에 실패하였습니다")
                        print("데이터베이스 연결에 실패하였습니다")
                    case 4011:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "비밀번호 암호화에 실패하였습니다")
                        print("비밀번호 암호화에 실패하였습니다")
                    default:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "알 수 없는 에러가 발생하였습니다.")
                        print("알 수 없는 에러가 발생하였습니다. : 코드번호 \(response.code)")
                    }
                case .failure(let error):
                    print("회원가입 실패")
                    debugPrint(error)
                }

            }
        
    }
}
