import UIKit
import XLPagerTabStrip
import SnapKit
import Then

class OffLineViewController: BaseViewController, IndicatorInfoProvider {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var goldHandCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "OffLineNearCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NearClassCell")
        collectionView.tag = 1
        
        goldHandCollectionView.delegate = self
        goldHandCollectionView.dataSource = self
        goldHandCollectionView.register(UINib(nibName: "GoldHandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GoldHandCell")
        goldHandCollectionView.tag = 2
        
        OffLineDataManager().requireOffLine( self) { data in
            Constant.classCategoryList = data.classCategoryList
            Constant.nearOfflineClassList = data.nearOfflineClassList
            Constant.newOpenOffLineClassesList = data.newOpenOffLineClassesList
            Constant.userAddressName = data.userAddressName
            self.collectionView.reloadData()
            self.goldHandCollectionView.reloadData()
        }
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "오프라인")
    }
    
    
}


extension OffLineViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            OfflineClassDetatilDataManager().requireOfflineClassDetail(Constant.nearOfflineClassList[indexPath.row].offlineClassID, self) { data in
                Constant.offlineClassDatailResult = data
                Constant.selectedOfflineClass = Constant.nearOfflineClassList[indexPath.row].offlineClassID
                let vc = OfflineClassDetailViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            }
        }
        else{
            OfflineClassDetatilDataManager().requireOfflineClassDetail(Constant.newOpenOffLineClassesList[indexPath.row].offlineClassID, self) { data in
                Constant.offlineClassDatailResult = data
                Constant.selectedOfflineClass = Constant.newOpenOffLineClassesList[indexPath.row].offlineClassID
                let vc = OfflineClassDetailViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1{
            
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            return CGSize(width: (width/2) - 16, height: 280)
        }
        else{
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            return CGSize(width: (width/2) - 16, height: 280)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1{
            
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "NearClassCell", for: indexPath) as! OffLineNearCollectionViewCell).then{
                let item = Constant.nearOfflineClassList[indexPath.row]
                
                $0.prepare(imageUrl: item.imgURL, categoryName: item.categoryName, title: item.title, countReview: "(\(item.countReview))", addressName: item.addressName, offClassID: item.offlineClassID, viewController: self, isLike: false)
            }
            cell.setViewRadius()
            return cell
        }
        else{
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "GoldHandCell", for: indexPath) as! GoldHandCollectionViewCell).then{
                let item = Constant.newOpenOffLineClassesList[indexPath.row]
                
                $0.prepare(imageUrl: item.imgURL, categoryName: item.categoryName, title: item.title, addressName: item.addressName, offClassID: item.offlineClassID, viewController: self, isLike: false)
                
            }
            cell.setViewRadius()
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1{
            return Constant.nearOfflineClassList.count
        }
        else{
            return Constant.newOpenOffLineClassesList.count
        }
    }
    
    
}
