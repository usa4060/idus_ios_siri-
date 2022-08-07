
import UIKit
import Kingfisher
import FloatingPanel

class ProductDetailViewController: BaseViewController , FloatingPanelControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var writerName: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var countReview: UILabel!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var countBuyer: UILabel!
    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var save: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var freeAmount: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var basketBtn: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    
    var productID = 0
    var viewController = UIViewController()
    var isLike = false
    
    
    
    @IBOutlet weak var shortReviewCollectionView: UICollectionView!
    
    var fpc: FloatingPanelController!
    var contentsVC: ProductBuyOptionViewController!
    //let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        shortReviewCollectionView.delegate = self
        shortReviewCollectionView.dataSource = self
        shortReviewCollectionView.tag = 1
        shortReviewCollectionView.register(UINib(nibName: "ProductShortReviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ShortReviewCell")
        
        ProductDetatilDataManager().requireProductDetail(Constant.selectedProduct, self) { data in
            Constant.productDetailInfo = data
            self.layoutConfiguration()
            self.shortReviewCollectionView.reloadData()
        }
    }
    
    
    private func layoutConfiguration(){
        
        self.productID = Constant.selectedProduct
        self.viewController = self
        
        buyBtn.layer.masksToBounds = true
        buyBtn.layer.borderWidth = 0
        buyBtn.layer.cornerRadius = 4
        basketBtn.layer.masksToBounds = true
        basketBtn.layer.borderWidth = 0
        basketBtn.layer.cornerRadius = 4
        
        likeCount.text = "\(Constant.productDetailInfo.countProductLike)"
        
        point.text = "\(Double(Constant.productDetailInfo.price ) * 0.01)P"
        
        isLike = Constant.productDetailInfo.like
        
        save.textColor = .darkGray
        
        pointView.layer.masksToBounds = true
        pointView.layer.borderWidth = 1
        pointView.layer.borderColor = UIColor.searchFieldBorderColor.cgColor
        pointView.layer.cornerRadius = 4
        let imageUrl = URL(string: "https://\(Constant.productDetailInfo.imgUrlList[0])")
        self.imageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "gift")){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        imageView.contentMode = .scaleAspectFill
        
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.borderWidth = 0
        profileImg.layer.masksToBounds = true
        profileImg.layer.cornerRadius = 12
        
        let profileUrl = URL(string: "https://\(Constant.productDetailInfo.profileImg ?? Constant.productDetailInfo.imgUrlList[0])")
        self.profileImg.kf.setImage(with: profileUrl, placeholder: UIImage(named: "gift")){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        writerName.text = Constant.productDetailInfo.writerName
        rating.text = "\(String(describing: Constant.productDetailInfo.rating))"
        countReview.text = "(\(String(describing: Constant.productDetailInfo.countReview)))"
        titleName.text = Constant.productDetailInfo.title
        price.text = "\(String(describing: Constant.productDetailInfo.price))"
        countBuyer.text = "\(String(describing: Constant.productDetailInfo.countBuyer))명의 고객님들이 구매했어요!"
        deliveryFee.text = "\(Constant.productDetailInfo.deliveryFee)원"
        freeAmount.text = "\(Constant.productDetailInfo.freeAmount)원 이상 무료 배송"
        
        if isLike == true {
            likeBtn.isSelected = true
            self.likeBtn.tintColor = .orange
        }
        else{
            likeBtn.isSelected = false
            self.likeBtn.tintColor = .black
        }
        
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func likeBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        
        
        if sender.isSelected == true{
            LikeProductPostDataManager().LikeProductPost(self.productID, self.viewController) { data in
                self.viewController.presentAlert(title: data)
            }
            DispatchQueue.main.async {
                self.likeBtn.tintColor = .orange
                self.likeCount.text = "\(Constant.productDetailInfo.countProductLike + 1)"
            }
        }
        else{
            
            LikeProductPatchDataManager().LikeProductPatch(self.productID, self.viewController) { data in
                self.viewController.presentAlert(title: data)
            }
            DispatchQueue.main.async {
                self.likeBtn.tintColor = .black
                self.likeCount.text = "\(Constant.productDetailInfo.countProductLike)"
            }
        }
    }
    
    @IBAction func basketBtnTapped(_ sender: UIButton) {
    }
    @IBAction func buyBtnTapped(_ sender: UIButton) {
        
        // 제품 옵션 설정은 미완
//        let vc = ProductBuyOptionViewController()
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        self.present(vc, animated: true)
    }
    
}


extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.productDetailInfo.shortReviewList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (shortReviewCollectionView.dequeueReusableCell(withReuseIdentifier: "ShortReviewCell", for: indexPath) as! ProductShortReviewCollectionViewCell).then {
            let shortReview = Constant.productDetailInfo.shortReviewList?[indexPath.row]
            $0.prepare(title: shortReview?.contents ?? "", url: shortReview?.imgUrl ?? "")
        }
        cell.setViewRadius()
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    
}
