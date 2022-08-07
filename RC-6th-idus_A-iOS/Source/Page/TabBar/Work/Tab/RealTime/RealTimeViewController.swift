import UIKit
import XLPagerTabStrip

class RealTimeViewController: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var onlyImageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onlyImageBtn.layer.masksToBounds = true
        onlyImageBtn.layer.borderWidth = 1
        onlyImageBtn.layer.borderColor = UIColor.lightGray.cgColor
        onlyImageBtn.layer.cornerRadius = 3
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "RealTimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RealTimeCell")
        collectionView.register(UINib(nibName: "OnlyImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnlyImageCell")
        RealTimeDataManager().requireRealTime(buyOrReview: 1, self) { data in
            Constant.realTimeProduct = data.realTimeProducts
            self.collectionView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "실시간")
    }
    
    
    @IBAction func onlyImageBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true{
            DispatchQueue.main.async {
                self.onlyImageBtn.layer.backgroundColor = UIColor.orange.cgColor
                self.onlyImageBtn.layer.borderWidth = 0
                self.onlyImageBtn.tintColor = .white
            }
        }
        else{
            DispatchQueue.main.async {
                self.onlyImageBtn.layer.backgroundColor = UIColor.white.cgColor
                self.onlyImageBtn.layer.borderWidth = 1
            }
        }
        self.collectionView.reloadData()
    }
    
}

extension RealTimeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        if onlyImageBtn.isSelected == true {
            return CGSize(width: (width/2) - 24, height: (width / 2) - 24)
        }
        else {
            return CGSize(width: (width/2) - 24, height: (width / 2) + 60)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ProductDetatilDataManager().requireProductDetail(Constant.realTimeProduct[indexPath.row].productID, self) { data in
            Constant.productDetailInfo = data
            
            Constant.selectedProduct = Constant.categoryProductList[0].productsList[indexPath.row].productID
            let vc = ProductDetailViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
            print(Constant.productDetailInfo)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.realTimeProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = Constant.realTimeProduct[indexPath.row]
        if onlyImageBtn.isSelected == true{
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "OnlyImageCell", for: indexPath) as! OnlyImageCollectionViewCell).then{
                $0.prepare(item.imgURL, item.productID, self, item.like)
            }
            
            return cell
        }
        else{
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "RealTimeCell", for: indexPath) as! RealTimeCollectionViewCell).then{
                $0.prepare(writerName: item.writerName, title: item.title, rating: "\(item.rating)", countReview: "\(item.countReview)", reviewContents: item.reviewContents, imageUrl: item.imgURL, productId: item.productID, viewController: self, isLike: item.like)
            }
            cell.imageView.snp.makeConstraints{
                $0.height.equalTo(cell.imageView.bounds.size.width)
            }
            return cell
        }
        
      
    }
    
    
}
