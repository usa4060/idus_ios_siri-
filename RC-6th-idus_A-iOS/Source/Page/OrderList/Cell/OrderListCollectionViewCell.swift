import Kingfisher
import UIKit

class OrderListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var finalPrice: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var writerName: UILabel!
    @IBOutlet weak var sendStatus: UILabel!
    @IBOutlet weak var orderAt: UILabel!
    
    @IBOutlet weak var viewLayer: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sendStatus.layer.masksToBounds = true
        sendStatus.layer.borderWidth = 1
        sendStatus.layer.borderColor = UIColor(hex: 0x8CC6CC).cgColor
        sendStatus.layer.cornerRadius = 2
        viewLayer.layer.borderColor = UIColor.lightGray.cgColor
        viewLayer.layer.borderWidth = 0.5
    }
    
    override func prepareForReuse() {
        prepare(productImg: "", finalPrice: 0, title: "", writerName: "", sendStatus: "", orderAt: "")
        
        super.prepareForReuse()
    }
    

    func prepare(productImg : String, finalPrice : Int, title : String, writerName : String, sendStatus : String, orderAt : String){
        
        
        self.productImg.contentMode = .scaleToFill
        self.productImg.kf.indicatorType = .activity
        let url = URL(string: "https://\(productImg)")
        self.productImg.kf.setImage(with: url){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        self.finalPrice.text = "\(finalPrice)원"
        self.title.text = title
        self.writerName.text = writerName
        self.sendStatus.text = sendStatus
        self.orderAt.text = orderAt
    }
}
