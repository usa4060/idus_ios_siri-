//
//  OnlyImageCollectionViewCell.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/09.
//

import UIKit

class OnlyImageCollectionViewCell: UICollectionViewCell {

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
        self.prepare("", 0, UIViewController(), false)
        super.prepareForReuse()
        
    }
    
    func prepare(_ imageUrl : String, _ productId : Int, _ viewController : UIViewController, _ isLike : Bool){
        
        self.productID = productId
        self.viewController = viewController
        self.isLike = isLike
        
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
            }
            LikeProductPatchDataManager().LikeProductPatch(self.productID, self.viewController) { data in
                self.viewController.presentAlert(title: data)
            }
        }
    }
    

}
