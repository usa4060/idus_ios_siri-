//
//  LikeOfflineClassCollectionViewCell.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/12.
//

import UIKit

class LikeOfflineClassCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var classImg: UIImageView!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var labelLayer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelLayer.layer.masksToBounds = true
        labelLayer.layer.borderWidth = 0
        labelLayer.layer.cornerRadius = 4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(classImg: "", addressName: "", categoryName: "", title: "", price: "")
        
    }
    
    func prepare(classImg : String, addressName : String, categoryName : String, title : String, price : String) {
        
        
        let url = URL(string: "https://\(classImg)")
        self.classImg.contentMode = .scaleToFill
        self.classImg.kf.indicatorType = .activity
        self.classImg.kf.setImage(with: url){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        self.addressName.text = addressName
        self.categoryName.text = categoryName
        self.title.text = title
        self.price.text = price
    }


}
