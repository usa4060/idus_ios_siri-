
import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var idusImage: UIImageView!
    @IBOutlet weak var kakaoLoginBtn: UIButton!
    @IBOutlet weak var defaultLoginBtn: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var appleLoginBtn: UIButton!
    
    
    let backgroundImageArray : [UIImage?] = [UIImage(named: "홈-백그라운드1"),UIImage(named: "홈-백그라운드2"),UIImage(named: "홈-백그라운드3")]
    var backgroundTimer : Timer?
    var count : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.layoutConfigure()
        self.count = 0
        self.backgroundTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: true)
    }
    
    @objc func changeBackground(){
        DispatchQueue.main.async {
            self.backgroundImageView.image = UIImage(named: "홈-백그라운드\(self.count%3 + 1)")
        }
        count+=1
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.backgroundTimer?.invalidate()
        self.backgroundTimer = nil
    }
    
    private func layoutConfigure(){
        
        idusImage.contentMode = .scaleAspectFill
        idusImage.layer.borderWidth = 0
        idusImage.layer.cornerRadius = 13
        
        kakaoLoginBtn.setBackgroundImage(UIImage(named: "kakaoLogin"), for: .normal)
        kakaoLoginBtn.clipsToBounds = true
        kakaoLoginBtn.layer.borderWidth = 0
        kakaoLoginBtn.layer.cornerRadius = 23
        
        defaultLoginBtn.clipsToBounds = true
        defaultLoginBtn.layer.borderWidth = 1.5
        defaultLoginBtn.layer.borderColor = UIColor.white.cgColor
        defaultLoginBtn.layer.cornerRadius = 22
        
        appleLoginBtn.clipsToBounds = true
        appleLoginBtn.layer.borderWidth = 0
        appleLoginBtn.layer.cornerRadius = 22
        
        backgroundImageView.image = UIImage(named:  "홈-백그라운드3")
        
        idusImage.contentMode = .scaleAspectFill
        backgroundImageView.contentMode = .scaleAspectFill
        
    }

    @IBAction func kakaoLoginBtnTapped(_ sender: Any) {
    }
    @IBAction func defaultLoginBtnTapped(_ sender: Any) {
        let existingMemberController = ExistingLoginViewController()
        existingMemberController.modalTransitionStyle = .coverVertical
        existingMemberController.modalPresentationStyle = .overFullScreen
        self.present(existingMemberController, animated: true, completion: nil)
        
    }
    @IBAction func noLoginTapped(_ sender: Any) {
//        let baseTabBarController = BaseTabBarViewController()
//        changeRootViewController(baseTabBarController)
//        UserSignInDataManager().signInUser("", "", self){ signData in
//            Constant.USER_ID = signData.userID
//            Constant.USER_JWTTOKEN = signData.jwt
//            AllProductDataManager().requireAllProduct(self) { data in
//                Constant.categoryProductList = data.categoryProductList
//                Constant.productReviewList = data.productReviewList
//                self.dismissIndicator()
//                let baseTabBarController = BaseTabBarViewController()
//                self.changeRootViewController(baseTabBarController)
//            }
//        }
    }
    
    @IBAction func anotherSignUpBtnTapped(_ sender: Any) {
        let email = UIAlertAction(title: "이메일", style: .default){action in
            let signUpController = SignUpViewController()
            signUpController.modalTransitionStyle = .coverVertical
            signUpController.modalPresentationStyle = .overFullScreen
            self.present(signUpController, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        self.presentAlert(title: "다른 방법으로 가입하기", preferredStyle: .actionSheet ,with: email, cancel)
    }
    
}
