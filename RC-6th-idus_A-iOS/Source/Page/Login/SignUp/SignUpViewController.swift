//
//  SignUpViewController.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/06/28.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    @IBOutlet var totalView: UIImageView!
    
    @IBOutlet weak var conditionsView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var checkPasswordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var allCheckBtn: UIButton!
    
    @IBOutlet weak var firstCheckBtn: UIButton!
    @IBOutlet weak var secondCheckBtn: UIButton!
    @IBOutlet weak var thirdCheckBtn: UIButton!
    @IBOutlet weak var fourthCheckBtn: UIButton!
    
    @IBOutlet weak var acceptAndSignBtn: UIButton!
    var checkCount : Int = 0
    
    
    override func viewDidLoad() {
        self.LayoutConfigure()
        checkCount = 0
        dismissKeyboardWhenTappedAround()
        super.viewDidLoad()
    }
    
    private func LayoutConfigure(){
        conditionsView.layer.borderWidth = 1
        conditionsView.layer.borderColor = UIColor.white.cgColor
        conditionsView.layer.masksToBounds = true
        conditionsView.layer.cornerRadius = 5
        
        let image = UIImage(named: "홈-백그라운드1")
        totalView.image = image?.applyBlur_usingClamp(radius: 20)
        totalView.contentMode = .scaleAspectFill
        
        allCheckBtn.layer.borderWidth = 1
        allCheckBtn.layer.borderColor = UIColor.white.cgColor
        allCheckBtn.layer.masksToBounds = true
        allCheckBtn.layer.cornerRadius = 3
        
        firstCheckBtn.layer.borderWidth = 1
        firstCheckBtn.layer.borderColor = UIColor.white.cgColor
        firstCheckBtn.layer.masksToBounds = true
        firstCheckBtn.layer.cornerRadius = 3
        
        secondCheckBtn.layer.borderWidth = 1
        secondCheckBtn.layer.borderColor = UIColor.white.cgColor
        secondCheckBtn.layer.masksToBounds = true
        secondCheckBtn.layer.cornerRadius = 3
        
        thirdCheckBtn.layer.borderWidth = 1
        thirdCheckBtn.layer.borderColor = UIColor.white.cgColor
        thirdCheckBtn.layer.masksToBounds = true
        thirdCheckBtn.layer.cornerRadius = 3
        
        fourthCheckBtn.layer.borderWidth = 1
        fourthCheckBtn.layer.borderColor = UIColor.white.cgColor
        fourthCheckBtn.layer.masksToBounds = true
        fourthCheckBtn.layer.cornerRadius = 3
        
        cancelBtn.tintColor = .white
        
        acceptAndSignBtn.clipsToBounds = true
        acceptAndSignBtn.layer.borderWidth = 1.5
        acceptAndSignBtn.layer.borderColor = UIColor.white.cgColor
        acceptAndSignBtn.layer.cornerRadius = 22
    }
    
    @IBAction func allCheckBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if(sender.isSelected){
            checkCount = 4
            firstCheckBtn.isSelected = true
            secondCheckBtn.isSelected = true
            thirdCheckBtn.isSelected = true
            fourthCheckBtn.isSelected = true
        }
        else{
            checkCount = 0
            firstCheckBtn.isSelected = false
            secondCheckBtn.isSelected = false
            thirdCheckBtn.isSelected = false
            fourthCheckBtn.isSelected = false
        }
    }
    
    @IBAction func firstBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if(sender.isSelected){
            checkCount += 1
            if checkCount == 4{
                allCheckBtn.isSelected = true
            }
        }
        else{
            allCheckBtn.isSelected = false
            checkCount -= 1
        }
    }
    @IBAction func secondBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if(sender.isSelected){
            checkCount += 1
            if checkCount == 4{
                allCheckBtn.isSelected = true
            }
        }
        else{
            allCheckBtn.isSelected = false
            checkCount -= 1
        }
    }
    @IBAction func thirdBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if(sender.isSelected){
            checkCount += 1
            if checkCount == 4{
                allCheckBtn.isSelected = true
            }
        }
        else{
            allCheckBtn.isSelected = false
            checkCount -= 1
        }
    }
    @IBAction func fourthBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if(sender.isSelected){
            checkCount += 1
            if checkCount == 4{
                allCheckBtn.isSelected = true
            }
        }
        else{
            allCheckBtn.isSelected = false
            checkCount -= 1
        }
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func acceptAndSignBtnTapped(_ sender: UIButton) {
        
        guard let email = emailField.text,
              let password = passwordField.text,
              let phoneNumber = phoneNumberField.text,
              let name = nameField.text else {return;}
        showIndicator()
        UserSignUpDataManager().signUpUser(email, name, password, phoneNumber, self){ data in
            print("처음 클로저")
            UserSignInDataManager().signInUser(email, password, self){ signData in
                print("안쪽에 들어옴")
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
     
        // 회원 데이터 넘겨주기
        // rootViewController Tab의 작품 View로 넘겨주기
    }
    
}
