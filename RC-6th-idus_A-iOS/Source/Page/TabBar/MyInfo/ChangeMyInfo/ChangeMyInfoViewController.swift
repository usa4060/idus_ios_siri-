//
//  ChangeMyInfoViewController.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/13.
//

import UIKit

class ChangeMyInfoViewController: UIViewController {
    
    @IBOutlet weak var phoneNumChangeBtn: UIButton!
    @IBOutlet weak var emailChangeBtn: UIButton!
    
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var myName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }


    private func configuration(){
        phoneNumChangeBtn.layer.masksToBounds = true
        phoneNumChangeBtn.layer.borderColor = UIColor.searchFieldBorderColor.cgColor
        phoneNumChangeBtn.layer.borderWidth = 1
        phoneNumChangeBtn.layer.cornerRadius = 3
        
        emailChangeBtn.layer.masksToBounds = true
        emailChangeBtn.layer.borderColor = UIColor.searchFieldBorderColor.cgColor
        emailChangeBtn.layer.borderWidth = 1
        emailChangeBtn.layer.cornerRadius = 3
        
        guard let name = Constant.myInfoDetailResult.userName else {return;}
        guard let phone = Constant.myInfoDetailResult.phoneNumber else {return;}
        guard let email = Constant.myInfoDetailResult.email else {return;}
        
        self.phoneNumber.text = phone
        self.myName.text = name
        self.email.text = email
        
    }
    @IBAction func phoneNumChangeBtnTapped(_ sender: UIButton) {
        
        let alter = UIAlertController(title: "변경하기", message: "\(Constant.myInfoDetailResult.phoneNumber ?? "")에서 변경할 전화번호를 입력해주세요", preferredStyle: .alert)
        alter.addTextField()
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            if let txt = alter.textFields?[0]{
                if txt.text?.isEmpty != true {
                    print(txt.text!)
                    ChangeMyPhoneNumberDataManager().changePhoneNumber(txt.text!, self) { data in
                        DispatchQueue.main.async {
                            self.phoneNumber.text = txt.text
                        }
                    }
                }
            }
        }
        alter.addAction(cancel)
        alter.addAction(ok)
        
        self.present(alter, animated: true)
        
        
    }
    @IBAction func emailChangeBtnTapped(_ sender: UIButton) {
        
        let alter = UIAlertController(title: "변경하기", message: "\(Constant.myInfoDetailResult.email ?? "")에서 변경할 이메일을 입력해주세요", preferredStyle: .alert)
        alter.addTextField()
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            if let txt = alter.textFields?[0]{
                if txt.text?.isEmpty != true {
                    ChangeMyEmailDataManager().changeEmail(txt.text!, self) { data in
                        DispatchQueue.main.async {
                            self.email.text = txt.text
                        }
                    }
                }
            }
        }
        alter.addAction(cancel)
        alter.addAction(ok)
        
        self.present(alter, animated: true)

    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func deleteMyInfo(_ sender: UIButton) {
        let vc = DeleteAccountViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}
