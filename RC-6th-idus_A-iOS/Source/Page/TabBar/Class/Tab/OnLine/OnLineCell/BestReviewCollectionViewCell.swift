
import UIKit
import Kingfisher

class BestReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var reviewImg: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var classImg: UIImageView!
    @IBOutlet weak var classTitle: UILabel!
    
    
    
    override func awakeFromNib() {
        reviewImg.layer.masksToBounds = true
        reviewImg.layer.borderWidth = 0
        reviewImg.layer.cornerRadius = 10
        reviewImg.contentMode = .scaleAspectFill
        
        classImg.layer.masksToBounds = true
        classImg.layer.borderWidth = 0
        classImg.layer.cornerRadius = 5
        classImg.contentMode = .scaleAspectFill
        
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(reviewImg: "", nickName: "", contents: "", classImg: "", classTitle: "")
    }
    
    func prepare(reviewImg : String , nickName : String?, contents: String?, classImg: String, classTitle: String?) {
        
        self.nickName.text = nickName
        self.contents.text = contents
        self.classTitle.text = classTitle
        
        let reviewImgUrl = URL(string: "https://\(reviewImg)")
        self.reviewImg.contentMode = .scaleToFill
        self.reviewImg.kf.indicatorType = .activity
        self.reviewImg.kf.setImage(with: reviewImgUrl){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        let classImgUrl = URL(string: "https://\(classImg)")
        self.classImg.contentMode = .scaleToFill
        self.classImg.kf.indicatorType = .activity
        self.classImg.kf.setImage(with: classImgUrl){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
    }
}
