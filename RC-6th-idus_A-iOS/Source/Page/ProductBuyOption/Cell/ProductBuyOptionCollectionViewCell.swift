//
//  ProductBuyOptionCollectionViewCell.swift
//  RC-6th-idus_A-iOS
//
//  Created by admin on 2022/07/13.
//

import UIKit

class ProductBuyOptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var optionTag: UILabel!
    @IBOutlet weak var optionList: UICollectionView!
    
    var myOptionDetailList : [OptionDetailList] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        optionList.delegate = self
        optionList.dataSource = self
        optionList.register(UINib(nibName: "OptionInCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OptionListCell")
        // Initialization code
        self.optionList.reloadData()
    }

    override func prepareForReuse() {
        self.prepare(optionTag: "", tagNum: 0, myOptionDetailList: [])
        super.prepareForReuse()
        
    }
    
    func prepare(optionTag : String, tagNum : Int, myOptionDetailList : [OptionDetailList]){
        self.optionTag.text = "\(tagNum). \(optionTag)"
        self.myOptionDetailList = myOptionDetailList
    }
}

extension ProductBuyOptionCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myOptionDetailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "OptionListCell", for: indexPath) as! OptionInCollectionViewCell).then{
            $0.prepare(option: self.myOptionDetailList[indexPath.row].optionDetailName, price: self.myOptionDetailList[indexPath.row].price)
        }
        return cell
    }
    
}
