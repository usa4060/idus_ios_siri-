import UIKit
import XLPagerTabStrip
import SnapKit
import Then

class ProductCategoryViewController: BaseViewController, IndicatorInfoProvider {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCategoryCell")
        
        ProductCategoryReqDataManager().requireProductCategory(self) { data in
            Constant.productCategoryList = data
            self.collectionView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "작품")
    }

}

extension ProductCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            Constant.selectedCategory = Constant.productCategoryList[indexPath.row].categoryID
            let vc = ProductCategoryDetailViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
                    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryCell", for: indexPath) as! ProductCategoryCollectionViewCell).then {
            let item = Constant.productCategoryList[indexPath.row]
            $0.prepare(imgUrl: "", productName: item.categoryName)
        }
        cell.imageView.layer.masksToBounds = true
        cell.imageView.layer.borderWidth = 0
        cell.imageView.layer.cornerRadius = cell.bounds.size.width/2 - 16
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.productCategoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Device.width
        let height = collectionView.bounds.height
        let itemsPerRow: CGFloat = 3
        let itemsPerColumn: CGFloat = 4.5
        let heightPadding = 12 * (itemsPerColumn + 1)
        let cellWidth = width / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth - 36, height: cellHeight - 12)
    }
}
