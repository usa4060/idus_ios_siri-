//
//  LikeOnlineClassCollectionViewCell.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/12.
//

import UIKit

class LikeOnlineClassCollectionViewCell: UICollectionViewCell {
      
    @IBOutlet weak var classImg: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var writerName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(classImg: "", categoryName: "", level: "", title: "", writerName: "")
        
    }
    
    func prepare(classImg : String, categoryName : String, level : String, title : String, writerName : String) {
        
        
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
        self.categoryName.text = categoryName
        self.level.text = level
        self.title.text = title
        self.writerName.text = writerName
    }

}
