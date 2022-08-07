//
//  DeleteAccountViewController.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/13.
//

import UIKit

class DeleteAccountViewController: UIViewController {
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var deleteAccountBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkBtn.isSelected = false
        checkBtn.layer.masksToBounds = true
        checkBtn.layer.cornerRadius = 2
        checkBtn.layer.borderWidth = 1
        checkBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        deleteAccountBtn.isSelected = false
        deleteAccountBtn.layer.masksToBounds = true
        deleteAccountBtn.layer.cornerRadius = 4
        deleteAccountBtn.layer.borderWidth = 1
        deleteAccountBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        deleteAccountBtn.tintColor = UIColor(hex: 0x939393)
        deleteAccountBtn.backgroundColor = UIColor(hex: 0xD2D2D2)
        deleteAccountBtn.isEnabled = false
        
    }
    
    
    @IBAction func checkBtnTapped(_ sender: UIButton) {
        checkBtn.isSelected.toggle()
        if checkBtn.isSelected == true{
            checkBtn.layer.borderWidth = 0
            checkBtn.layer.backgroundColor = UIColor.orange.cgColor
            checkBtn.tintColor = .white
            
            deleteAccountBtn.titleLabel?.textColor = .white
            deleteAccountBtn.layer.backgroundColor = UIColor.orange.cgColor
            deleteAccountBtn.isEnabled = true
        }
        else{
            checkBtn.layer.borderWidth = 1
            checkBtn.layer.backgroundColor = UIColor.white.cgColor
            
            deleteAccountBtn.titleLabel?.textColor = UIColor(hex: 0x939393)
            deleteAccountBtn.backgroundColor = UIColor(hex: 0xD2D2D2)
            deleteAccountBtn.isEnabled = false
        }
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func deleteAccountBtnTapped(_ sender: UIButton) {
        DeleteMyInfoDataManager().deleteMyInfo(self) { data in
            self.presentAlert(title: data)
            let goToLoginViewController = LoginViewController()
            self.changeRootViewController(goToLoginViewController)
        }
    }
}
