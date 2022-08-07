import UIKit
import XLPagerTabStrip

class LikeProductViewController: BaseViewController, IndicatorInfoProvider  {

    @IBOutlet weak var onlyImgBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onlyImgBtn.layer.masksToBounds = true
        onlyImgBtn.layer.borderWidth = 1
        onlyImgBtn.layer.borderColor = UIColor.lightGray.cgColor
        onlyImgBtn.layer.cornerRadius = 3
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "LikeProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LikeProductCell")
        collectionView.register(UINib(nibName: "OnlyImageLikeProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnlyImageLikeProduct")
        LikeProductGetDataManager().requireLikeProduct(self) { data in
            Constant.likeProductResult = data
            self.collectionView.reloadData()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "작품")
    }
    
    
    @IBAction func onlyImgBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true{
            DispatchQueue.main.async {
                self.onlyImgBtn.layer.backgroundColor = UIColor.orange.cgColor
                self.onlyImgBtn.layer.borderWidth = 0
                self.onlyImgBtn.tintColor = .white
            }
        }
        else{
            DispatchQueue.main.async {
                self.onlyImgBtn.layer.backgroundColor = UIColor.white.cgColor
                self.onlyImgBtn.layer.borderWidth = 1
            }
        }
        self.collectionView.reloadData()
    }
    
}

extension LikeProductViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        if onlyImgBtn.isSelected == true {
            return CGSize(width: (width/2) - 24, height: (width / 2) - 24)
        }
        else {
            return CGSize(width: (width/2) - 24, height: (width / 2) + 60)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = Constant.likeProductResult[indexPath.row]
        Constant.selectedProduct = item.productID
        ProductDetatilDataManager().requireProductDetail(item.productID, self) { data in
            Constant.productDetailInfo = data
            let vc = ProductDetailViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.likeProductResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = Constant.likeProductResult[indexPath.row]
        if onlyImgBtn.isSelected == true{
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "OnlyImageLikeProduct", for: indexPath) as! OnlyImageLikeProductCollectionViewCell).then{
                $0.prepare(imageUrl: item.imgURL)
            }
            return cell
        }
        else{
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "LikeProductCell", for: indexPath) as! LikeProductCollectionViewCell).then{
                $0.prepare(writerName: item.writerName, title: item.title, rating: "\(item.rating)", countReview: "\(item.countReview)", reviewContents: item.lastReview, productImg: item.imgURL, price: "\(item.price)")
            }
            cell.productImg.snp.makeConstraints{
                $0.height.equalTo(cell.productImg.bounds.size.width)
            }
            return cell
        }
        
      
    }
    
    
}

