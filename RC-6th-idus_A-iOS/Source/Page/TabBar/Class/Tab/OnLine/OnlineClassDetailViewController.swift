
import UIKit
import Kingfisher

class OnlineClassDetailViewController: BaseViewController {
    
    @IBOutlet weak var videoUrl: UIImageView!
    @IBOutlet weak var writerUrl: UIImageView!
    @IBOutlet weak var writerName: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var startingDay: UILabel!
    @IBOutlet weak var level: UILabel!
    
    @IBOutlet weak var likeLayer: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        OnlineClassDetatilDataManager().requireOnlineClassDetail(Constant.selectedOnlineClass, self) { data in
            Constant.onlineClassDetailResult = data
            self.layoutConfiguration()
        }
        
    }
    
    private func layoutConfiguration(){
        let url = URL(string: "https://\(Constant.onlineClassDetailResult.videoURL)")
        self.videoUrl.kf.setImage(with: url){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        videoUrl.contentMode = .scaleAspectFill
        likeLayer.layer.borderWidth = 1
        likeLayer.layer.borderColor = UIColor.lightGray.cgColor
        likeLayer.layer.masksToBounds = true
        likeLayer.layer.cornerRadius = 4
        let writerUrl = URL(string: "https://\(Constant.onlineClassDetailResult.writerImg)")
        self.writerUrl.kf.setImage(with: writerUrl){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        self.writerUrl.contentMode = .scaleAspectFill
        self.writerUrl.layer.borderWidth = 0
        self.writerUrl.layer.masksToBounds = true
        self.writerUrl.layer.cornerRadius = 12
        
        let item = Constant.onlineClassDetailResult
        writerName.text = item.writerName
        categoryName.text = item.categoryName
        titles.text = item.title
        startingDay.text = item.startingDay
        level.text = item.level
        
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}


