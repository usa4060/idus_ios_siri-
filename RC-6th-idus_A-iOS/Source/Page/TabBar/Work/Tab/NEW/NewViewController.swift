import UIKit
import XLPagerTabStrip

class NewViewController: BaseViewController, IndicatorInfoProvider {
    
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
        
        collectionView.register(UINib(nibName: "NewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewCell")
        collectionView.register(UINib(nibName: "OnlyImageNewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnlyImageNewCell")
        NewDataManager().requireNew(buyOrReview: 1, self) { data in
            Constant.newProduct = data.newProductsList
            print(Constant.realTimeProduct)
            self.collectionView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "NEW")
    }
    
    @IBAction func onlyImageBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true{
            DispatchQueue.main.async {
                self.onlyImageBtn.layer.backgroundColor = UIColor.orange.cgColor
                self.onlyImageBtn.layer.borderWidth = 0
                self.onlyImageBtn.tintColor = .white
            }
            print(1)
        }
        else{
            DispatchQueue.main.async {
                self.onlyImageBtn.layer.backgroundColor = UIColor.white.cgColor
                self.onlyImageBtn.layer.borderWidth = 1
            }
            print(2)
        }
        self.collectionView.reloadData()
    }
    
}

extension NewViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        if onlyImageBtn.isSelected == true {
            return CGSize(width: (width/2) - 24, height: (width/2) - 24)
        }
        else {
            return CGSize(width: (width/2) - 24, height: (width/2) + 24)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ProductDetatilDataManager().requireProductDetail(Constant.newProduct[indexPath.row].productID, self) { data in
            Constant.productDetailInfo = data
            let vc = ProductDetailViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
            //self.navigationController?.pushViewController(vc, animated: true)
            print(Constant.productDetailInfo)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.newProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = Constant.newProduct[indexPath.row]
        if onlyImageBtn.isSelected == true{
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "OnlyImageNewCell", for: indexPath) as! OnlyImageNewCollectionViewCell).then{
                $0.prepare(item.imgURL, item.productID, self, item.like)
            }
            cell.imageView.snp.makeConstraints{
                $0.height.equalTo(cell.imageView.bounds.size.width)
            }
            return cell
        }
        else{
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "NewCell", for: indexPath) as! NewCollectionViewCell).then{
                $0.prepare(writerName: item.writerName, title: item.title, imageUrl: item.imgURL, productId: item.productID, viewController: self, isLike: item.like)
            }
            cell.imageView.snp.makeConstraints{
                $0.height.equalTo(cell.imageView.bounds.size.width)
            }
            return cell
        }
        
      
    }
    
    
}
