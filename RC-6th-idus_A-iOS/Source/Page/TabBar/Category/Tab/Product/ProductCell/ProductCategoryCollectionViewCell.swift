//
//  ProductCategoryCollectionViewCell.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/10.
//

import UIKit

class ProductCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        // Initialization code
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(imgUrl: "", productName: "")
    }
    
    func prepare(imgUrl : String , productName : String) {
        self.productName.text = productName
    }
}
