import UIKit
import SnapKit
import Kingfisher

class GoldHandCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var oppView: UIView!
    @IBOutlet weak var imgUrl: UIImageView!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var offClassID = 0
    var viewController = UIViewController()
    var isLike = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgUrl.contentMode = .scaleAspectFill
        
        
        
        oppView.layer.masksToBounds = true
        oppView.layer.borderWidth = 0
        oppView.layer.cornerRadius = 4
        
        imgUrl.snp.makeConstraints{
            $0.height.equalTo(self.snp.width)
        }
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(imageUrl: "", categoryName: "", title: "", addressName: "", offClassID: 0, viewController: UIViewController(), isLike: false)
    }
    
    func prepare(imageUrl : String , categoryName : String?, title: String?, addressName: String?, offClassID : Int, viewController : UIViewController, isLike: Bool) {
        
        self.offClassID = offClassID
        self.viewController = viewController
        
        self.imgUrl.image = UIImage(named: imageUrl)
        let url = URL(string: "https://\(imageUrl)")
        self.imgUrl.kf.indicatorType = .activity
        self.imgUrl.kf.setImage(with: url){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        self.categoryName.text = categoryName
        self.title.text = title
        self.addressName.text = addressName
        
        if isLike == true {
            likeBtn.isSelected = true
            self.likeBtn.tintColor = .orange
        }
        else{
            likeBtn.isSelected = false
            self.likeBtn.tintColor = .white
        }
    }
    
    
    @IBAction func likeBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true{
            DispatchQueue.main.async {
                self.likeBtn.tintColor = .orange
            }
            LikeOfflineClassPostDataManager().LikeOfflineClassPost(self.offClassID, self.viewController) { data in
                self.viewController.presentAlert(title: data)
            }
        }
        else{
            DispatchQueue.main.async {
                self.likeBtn.tintColor = .white
            }
            LikeOfflineClassPatchDataManager().LikeOfflineClassPatch(self.offClassID, self.viewController) { data in
                self.viewController.presentAlert(title: data)
            }
        }
    }
    
}

