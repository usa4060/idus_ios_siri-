//
//  NewCollectionViewCell.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/09.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var writerName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
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
        
        self.prepare(writerName: "", title: "", imageUrl: "", productId: 0, viewController: UIViewController(), isLike: false)
    }
    
    func prepare(writerName : String? , title : String?, imageUrl : String, productId : Int, viewController : UIViewController, isLike : Bool) {
        
        self.productID = productId
        self.viewController = viewController
        
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
        self.writerName.text = writerName
        self.title.text = title
        
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
