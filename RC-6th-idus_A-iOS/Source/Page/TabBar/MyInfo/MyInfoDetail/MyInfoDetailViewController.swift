//
//  MyInfoDetailViewController.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/12.
//

import UIKit

class MyInfoDetailViewController: UIViewController {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyInfoDetailReqDataManager().requireMyInfoDetail(self) { data in
            Constant.myInfoDetailResult = data
            self.configurate()
        }
    }
    
    private func configurate(){
        var info = Constant.myInfoDetailResult
        guard let name = info.userName else {return; }
        guard let email = info.email else {return;}
        guard let phoneNumber = info.phoneNumber else {return;}
        guard let profileImg = info.profileImg else {return;}
        
        let url = URL(string: "https://\(profileImg)")
        self.profileImg.kf.indicatorType = .activity
        self.profileImg.kf.setImage(with: url){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        self.profileImg.layer.masksToBounds = true
        self.profileImg.layer.borderWidth = 0
        self.profileImg.layer.cornerRadius = self.profileImg.bounds.size.width / 2
        self.profileImg.contentMode = .scaleToFill
        
        
        userName.text = name
        self.email.text = email
    }
    
    @IBAction func disMissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
        Constant.clearMemeber()
        let goToLoginViewController = LoginViewController()
        self.changeRootViewController(goToLoginViewController)
    }
    
    @IBAction func changeInfo(_ sender: UIButton) {
        let vc = ChangeMyInfoViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    
}
