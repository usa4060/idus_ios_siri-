//
//  ProductShortReviewCollectionViewCell.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/10.
//

import UIKit

class ProductShortReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 2
        
        imageView.snp.makeConstraints{
            $0.width.equalTo(60)
        }
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare( title: "", url: "")
    }
    
    func prepare(title: String?, url: String) {
        imageView.contentMode = .scaleToFill
        let url = URL(string: "https://\(url)")
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
        self.title.text = title
    }
}
