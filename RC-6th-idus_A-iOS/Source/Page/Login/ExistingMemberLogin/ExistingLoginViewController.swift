//
//  ExistingLoginViewController.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/06/28.
//

import UIKit

class ExistingLoginViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var naverLoginBtn: UIButton!
    @IBOutlet weak var facebookLoginBtn: UIButton!
    @IBOutlet weak var kakaoLoginBtn: UIButton!
    @IBOutlet weak var twiterLoginBtn: UIButton!
    @IBOutlet weak var appleLoginBtn: UIButton!
    
    @IBOutlet weak var emailLoginBtn: UIButton!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        layoutConfiguration()
        dismissKeyboardWhenTappedAround()
        super.viewDidLoad()
    }
    
    private func layoutConfiguration(){
        let image = UIImage(named: "홈-백그라운드1")
        backgroundView.image = image?.applyBlur_usingClamp(radius: 20)
        backgroundView.contentMode = .scaleAspectFill
        
        naverLoginBtn.clipsToBounds = true
        naverLoginBtn.layer.borderWidth = 1
        naverLoginBtn.layer.borderColor = UIColor.white.cgColor
        naverLoginBtn.layer.cornerRadius = 22
        
        facebookLoginBtn.clipsToBounds = true
        facebookLoginBtn.layer.borderWidth = 1
        facebookLoginBtn.layer.borderColor = UIColor.white.cgColor
        facebookLoginBtn.layer.cornerRadius = 22
        
        kakaoLoginBtn.clipsToBounds = true
        kakaoLoginBtn.layer.borderWidth = 1
        kakaoLoginBtn.layer.borderColor = UIColor.white.cgColor
        kakaoLoginBtn.layer.cornerRadius = 22
        
        twiterLoginBtn.clipsToBounds = true
        twiterLoginBtn.layer.borderWidth = 1
        twiterLoginBtn.layer.borderColor = UIColor.white.cgColor
        twiterLoginBtn.layer.cornerRadius = 22
        
        appleLoginBtn.clipsToBounds = true
        appleLoginBtn.layer.borderWidth = 0
        appleLoginBtn.layer.cornerRadius = 22
        
        emailLoginBtn.clipsToBounds = true
        emailLoginBtn.layer.borderWidth = 1
        emailLoginBtn.layer.borderColor = UIColor.white.cgColor
        emailLoginBtn.layer.cornerRadius = 22
        
        closeBtn.tintColor = .white
    }
    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        guard let email = emailField.text,
              let password = passwordField.text
        else {return;}
        showIndicator()
        UserSignInDataManager().signInUser(email, password, self){ signData in
            Constant.USER_ID = signData.userID
            Constant.USER_JWTTOKEN = signData.jwt
            AllProductDataManager().requireAllProduct(self) { data in
                Constant.categoryProductList = data.categoryProductList
                Constant.productReviewList = data.productReviewList
                print("로그인 화면에서의 categoryProduct의 갯수 : \(data.categoryProductList.count)")
                print("로그인 화면에서의 productReviewList의 갯수 : \(data.productReviewList.count)")
                let baseTabBarController = BaseTabBarViewController()
                self.dismissIndicator()
                self.changeRootViewController(baseTabBarController)
            }
            
        }
    }
}
