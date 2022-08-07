
import UIKit
import Kingfisher
class RealTimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var writerName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var countReview: UILabel!
    @IBOutlet weak var reviewContents: UILabel!
    @IBOutlet weak var review: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    var productID = 0
    var viewController = UIViewController()
    var isLike = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        review.layer.borderWidth = 0
        review.layer.backgroundColor = UIColor.searchFieldBorderColor.cgColor
        review.layer.masksToBounds = true
        review.layer.cornerRadius = 8
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(writerName: "", title: "", rating: "", countReview: "", reviewContents: "", imageUrl: "", productId: 0, viewController: UIViewController(), isLike: false)
    }
    
    func prepare(writerName : String? , title : String?, rating: String?, countReview: String, reviewContents: String?, imageUrl: String, productId : Int, viewController : UIViewController, isLike : Bool) {
        
        self.productID = productId
        self.viewController = viewController
        
        self.writerName.text = writerName
        self.title.text = title
        self.rating.text = rating
        self.countReview.text = "(\(countReview))"
        self.reviewContents.text = reviewContents
        let url = URL(string: "https://\(imageUrl)")
        self.imageView.contentMode = .scaleToFill
        self.imageView.kf.indicatorType = .activity
        self.imageView.kf.setImage(with: url){
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
                LikeProductPatchDataManager().LikeProductPatch(self.productID, self.viewController) { data in
                    self.viewController.presentAlert(title: data)
                }
            }
        }
    }
}
