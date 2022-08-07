import UIKit

class ProductBuyOptionViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductBuyOptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductOptionTagCell")
        BuyOptionGetDataManager().requireLikeOfflineClass(Constant.selectedProduct, self) { data in
            Constant.productOptionList = data
            self.collectionView.reloadData()
        }
    }


}

extension ProductBuyOptionViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ProductOptionTagCell", for: indexPath) as! ProductBuyOptionCollectionViewCell).then{
            let item = Constant.productOptionList
            $0.prepare(optionTag: item[indexPath.row].optionName, tagNum: item[indexPath.row].optionId, myOptionDetailList: item[indexPath.row].optionDetailList)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.productOptionList.count
    }
    
}
