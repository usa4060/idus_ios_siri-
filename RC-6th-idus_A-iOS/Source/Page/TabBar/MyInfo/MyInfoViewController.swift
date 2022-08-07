import UIKit
import Kingfisher

class MyInfoViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var rewardPoint: UILabel!
    @IBOutlet weak var countCoupon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyInfoReqDataManager().requireMyInfo(self) { data in
            Constant.myInfoReqResult = data
            self.configurate()
        }

    }
    
    private func configurate(){
        let info = Constant.myInfoReqResult
        
        let url = URL(string: "https://\(info.profileImg)")
        profileImg.kf.setImage(with: url){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        profileImg.layer.masksToBounds = true
        profileImg.layer.borderWidth = 0
        profileImg.layer.cornerRadius = profileImg.bounds.size.width / 2
        profileImg.contentMode = .scaleToFill
        
        userName.text = info.userName
        grade.text = info.grade
        rewardPoint.text = "\(info.rewardPoint)"
        countCoupon.text = "\(info.countCoupon)"
        
    }

    @IBAction func likeListBtnTapped(_ sender: UIButton) {
        let vc = LikesViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    @IBAction func optionBtnTapped(_ sender: UIButton) {
        let vc = MyInfoDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    @IBAction func orderList(_ sender: UIButton) {
        let vc = OrderListViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    
}
