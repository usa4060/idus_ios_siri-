//
//  LikeProductCollectionViewCell.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/12.
//

import UIKit

class LikeProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var writerName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var countReview: UILabel!
    @IBOutlet weak var reviewContents: UILabel!
    
    @IBOutlet weak var review: UILabel!

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
        
        self.prepare(writerName: "", title: "", rating: "", countReview: "", reviewContents: "", productImg: "", price: "")
    }
    
    func prepare(writerName : String? , title : String?, rating: String?, countReview: String, reviewContents: String?, productImg : String, price : String) {
        
        
        let url = URL(string: "https://\(productImg)")
        self.productImg.contentMode = .scaleToFill
        self.productImg.kf.indicatorType = .activity
        self.productImg.kf.setImage(with: url){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        self.price.text = price
        self.writerName.text = writerName
        self.title.text = title
        self.rating.text = rating
        self.countReview.text = "(\(countReview))"
        self.reviewContents.text = reviewContents
    }
}
