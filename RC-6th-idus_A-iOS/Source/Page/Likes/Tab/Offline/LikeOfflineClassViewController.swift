import UIKit
import XLPagerTabStrip

class LikeOfflineClassViewController: BaseViewController , IndicatorInfoProvider{

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "LikeOfflineClassCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LikeOfflineClassCell")
        
        LikeOfflineClassDataManager().requireLikeOfflineClass(self) { data in
            Constant.likeOfflineClassResult = data
            self.collectionView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "오프라인 클래스")
    }
}

extension LikeOfflineClassViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height

        return CGSize(width: width - 24, height: height / 4)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = Constant.likeOfflineClassResult[indexPath.row]
        Constant.selectedOfflineClass = item.offlineClassID
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.likeOfflineClassResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = Constant.likeOfflineClassResult[indexPath.row]
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "LikeOfflineClassCell", for: indexPath) as! LikeOfflineClassCollectionViewCell).then{
                $0.prepare(classImg: item.classImg, addressName: item.addressName, categoryName: item.categoryName, title: item.title, price: "\(item.price)")
            }
        cell.classImg.snp.makeConstraints{
            $0.width.equalTo(cell.classImg.bounds.size.height)
        }
        cell.setViewRadius()
        return cell
    }
    
    
}

