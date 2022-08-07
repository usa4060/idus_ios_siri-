import Kingfisher
import UIKit

class OnlyImageProductCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    
    var productID = 0
    var viewController = UIViewController()
    var isLike = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(imageUrl: "", 0, UIViewController(), false)
    }
    func prepare(imageUrl : String, _ productId : Int, _ viewController : UIViewController, _ isLike : Bool) {
        
        self.productID = productId
        self.viewController = viewController
        self.isLike = isLike
        
        let url = URL(string: "https://\(imageUrl)")
        self.image.contentMode = .scaleToFill
        self.image.kf.setImage(with: url){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
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
            LikeProductPostDataManager().LikeProductPost(self.productID, self.viewController) { data in
                self.viewController.presentAlert(title: data)
            }
        }
        else{
            DispatchQueue.main.async {
                self.likeBtn.tintColor = .white
            }
            LikeProductPatchDataManager().LikeProductPatch(self.productID, self.viewController) { data in
                self.viewController.presentAlert(title: data)
            }
        }
    }
    
}
