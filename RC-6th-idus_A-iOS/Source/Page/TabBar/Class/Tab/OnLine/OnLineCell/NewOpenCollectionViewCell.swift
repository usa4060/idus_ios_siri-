//
//  BestReviewCollectionViewCell.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/09.
//

import UIKit

class NewOpenCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var writerName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var onClassID = 0
    var viewController = UIViewController()
    var isLike = false
    
    override func awakeFromNib() {
        profileImg.layer.masksToBounds = true
        profileImg.layer.borderWidth = 0
        profileImg.layer.cornerRadius = 3
        profileImg.contentMode = .scaleAspectFill
        
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(profileImg: "", categoryName: "", writerName: "", title: "", onClassID: 0, viewController: UIViewController(), isLike: false)
    }
    
    func prepare(profileImg : String , categoryName : String?, writerName: String?, title: String, onClassID : Int, viewController : UIViewController, isLike: Bool) {
        
        self.onClassID = onClassID
        self.viewController = viewController
        
        self.profileImg.image = UIImage(named: profileImg)
        self.categoryName.text = categoryName
        self.writerName.text = writerName
        self.title.text = title
        
        let profileImgUrl = URL(string: "https://\(profileImg)")
        self.profileImg.contentMode = .scaleToFill
        self.profileImg.kf.indicatorType = .activity
        self.profileImg.kf.setImage(with: profileImgUrl){
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
                LikeOnlineClassPostDataManager().LikeOnlineClassPost(self.onClassID, self.viewController) { data in
                    self.viewController.presentAlert(title: data)
                }
            }
        }
        else{
            DispatchQueue.main.async {
                self.likeBtn.tintColor = .white
            }
            LikeOnlineClassPatchDataManager().LikeOnlineClassPatch(self.onClassID, self.viewController) { data in
                self.viewController.presentAlert(title: data)
            }
        }
        
    }
    
}
