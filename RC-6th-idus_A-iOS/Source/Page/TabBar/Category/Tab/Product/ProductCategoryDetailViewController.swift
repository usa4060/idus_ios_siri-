import UIKit

class ProductCategoryDetailViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var onlyImageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        onlyImageBtn.layer.masksToBounds = true
        onlyImageBtn.layer.borderWidth = 1
        onlyImageBtn.layer.borderColor = UIColor.lightGray.cgColor
        onlyImageBtn.layer.cornerRadius = 3
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ProductCategoryDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCategoryDetailCell")
        collectionView.register(UINib(nibName: "OnlyImageProductCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnlyImageProductCategoryCell")
        
        ProductCategoryDetailReqDataManager().requireProductCategoryDetail(Constant.selectedCategory, self) { data in
            Constant.productCaregoryDetailList = data
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
//        Constant.productCaregoryDetailList.removeAll()
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


extension ProductCategoryDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        if onlyImageBtn.isSelected == true {
            return CGSize(width: (width/2) - 20, height: (width / 2) - 24)
        }
        else {
            return CGSize(width: (width/2) - 20, height: (width / 2) + 80)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = Constant.productCaregoryDetailList[indexPath.row]
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
        return Constant.productCaregoryDetailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = Constant.productCaregoryDetailList[indexPath.row]
        if onlyImageBtn.isSelected == true{
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "OnlyImageProductCategoryCell", for: indexPath) as! OnlyImageProductCategoryCollectionViewCell).then{
                $0.prepare(imageUrl: item.productImg,  item.productID, self, item.userLike)
            }
            return cell
        }
        else{
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryDetailCell", for: indexPath) as! ProductCategoryDetailCollectionViewCell).then{
                $0.prepare(writerName: item.writerName, title: item.title, rating: "\(item.rating)", countReview: "\(item.countReview)", reviewContents: item.lastReview, productImg: item.productImg, price: "\(item.price)", productId: item.productID, viewController: self, isLike: item.userLike)
            }
            cell.productImg.snp.makeConstraints{
                $0.height.equalTo(cell.productImg.bounds.size.width)
            }
            return cell
        }
        
        
    }
    
    
}
