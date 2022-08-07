//
//  OptionInCollectionViewCell.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/13.
//

import UIKit

class OptionInCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        prepare(option: "", price: 0)
        
        super.prepareForReuse()
    }
    
    func prepare(option : String, price: Int){
        self.optionName.text = option
        self.price.text = "\(price)원"
    }
}
