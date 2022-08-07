import UIKit
import XLPagerTabStrip

class LikeOnlineViewController: BaseViewController ,IndicatorInfoProvider{

    @IBOutlet weak var collecitonView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collecitonView.delegate = self
        collecitonView.dataSource = self
        
        collecitonView.register(UINib(nibName: "LikeOnlineClassCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LikeOnlineClassCell")
        
        LikeOnlineClassDataManager().requireLikeOnlineClass(self) { data in
            Constant.likeOnlineClassResult = data
            self.collecitonView.reloadData()
        }
        
    }


    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "온라인 클래스")
    }

}

extension LikeOnlineViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height

        return CGSize(width: width - 16, height: height / 2)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let item = Constant.likeOnlineClassResult[indexPath.row]
//        Constant.selectedOnlineClass = item.onlineClassID
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.likeOnlineClassResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = Constant.likeOnlineClassResult[indexPath.row]
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "LikeOnlineClassCell", for: indexPath) as! LikeOnlineClassCollectionViewCell).then{
                $0.prepare(classImg: item.classImg, categoryName: item.categoryName, level: item.level, title: item.title, writerName: item.writerName)
            }
        cell.setViewRadius()
        return cell
    }
    
    
}

