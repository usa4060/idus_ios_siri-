import Kingfisher
import UIKit

class OnlyImageLikeProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(imageUrl: "")
    }
    func prepare(imageUrl : String) {
        
        let url = URL(string: "https://\(imageUrl)")
        self.image.contentMode = .scaleToFill
        self.image.kf.indicatorType = .activity
        self.image.kf.setImage(with: url){
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
